extern crate grok;

use std::fs::File;
use std::path::Path;
use std::io::BufRead;
use std::io::BufReader;
use std::io::Error;
use std::collections::HashSet;

#[allow(dead_code)]
fn read_file(filename: &str) -> Result<Vec<String>, Error> {
    let path = Path::new(filename);
    let file = File::open(&path)?;
    let reader = BufReader::new(file);
    reader.lines().filter(|line| !line.as_ref().unwrap().is_empty()).collect()
}

#[allow(dead_code)]
#[derive(Debug, Clone)]
enum Instruction {
    Acc,
    Jmp,
    Nop,
}

#[allow(dead_code)]
fn parse_instruction(line: String) -> (Instruction, isize) {
    let split = line.split(' ').collect::<Vec<&str>>();
    let instruction = match split[0] {
        "nop" => Instruction::Nop,
        "jmp" => Instruction::Jmp,
        "acc" => Instruction::Acc,
        _ => panic!("crash and burn"),
    };
    let str_value = split[1];
    let value = str_value.parse::<isize>().unwrap();
    (instruction, value)
}

#[allow(dead_code)]
fn parse_program(lines: Vec<String>) -> Vec<(Instruction, isize)> {
    lines.into_iter().map(parse_instruction).collect::<Vec<(Instruction, isize)>>()
}

#[allow(dead_code)]
#[derive(Debug)]
struct Computer {
    instruction_pointer: usize,
    program: Vec<(Instruction, isize)>,
    accumulator: isize,
}

#[derive(PartialEq)]
enum ExitCode {
    Loop,
    Terminated,
}

#[allow(dead_code)]
impl Computer {
    fn step(&mut self) {
        let (instruction, value) = &self.program[self.instruction_pointer];
        match instruction {
            Instruction::Acc => {self.accumulator += value; self.instruction_pointer += 1},
            Instruction::Jmp => self.instruction_pointer = ((self.instruction_pointer as isize) + value) as usize,
            Instruction::Nop => self.instruction_pointer += 1,
        }
    }

    fn run_until_termination(&mut self) -> ExitCode {
        let mut executed_instructions: HashSet<usize> = HashSet::new();
        while !executed_instructions.contains(&self.instruction_pointer) {
            if self.instruction_pointer >= self.program.len() {
                return ExitCode::Terminated
            }
            //println!("{:?} {:?} {:?}", self.instruction_pointer, self.program[self.instruction_pointer], self.accumulator);
            executed_instructions.insert(self.instruction_pointer);
            self.step()
        }
        ExitCode::Loop
    }
}

#[allow(dead_code)]
fn try_mutate_fix_program(program: &Vec<(Instruction, isize)>) -> Computer {
    for x in 0..program.len() {
        let mut new_program = program.clone();
        match new_program[x].0 {
            Instruction::Acc => continue,
            Instruction::Nop => new_program[x].0 = Instruction::Jmp,
            Instruction::Jmp => new_program[x].0 = Instruction::Nop,
        }
        let mut computer = Computer {
            program: new_program,
            instruction_pointer: 0,
            accumulator: 0,
        };
        if computer.run_until_termination() == ExitCode::Terminated {
            return computer
        }
    }
    panic!("couldn't find the needed mutation");
}


#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn example1() {
        let program_lines = read_file("day8_ex1.txt").unwrap();
        let program = parse_program(program_lines);
        let mut computer = Computer {
            program: program,
            instruction_pointer: 0,
            accumulator: 0,
        };
        computer.run_until_termination();
        assert_eq!(computer.accumulator, 5);
    }

    #[test]
    fn part1() {
        let program_lines = read_file("day8.txt").unwrap();
        let program = parse_program(program_lines);
        let mut computer = Computer {
            program: program,
            instruction_pointer: 0,
            accumulator: 0,
        };
        computer.run_until_termination();
        assert_eq!(computer.accumulator, 1810);
    }

    #[test]
    fn example2() {
        let program_lines = read_file("day8_ex1.txt").unwrap();
        let program = parse_program(program_lines);
        let computer = try_mutate_fix_program(&program);
        assert_eq!(computer.accumulator, 8);
    }

    #[test]
    fn part2() {
        let program_lines = read_file("day8.txt").unwrap();
        let program = parse_program(program_lines);
        let computer = try_mutate_fix_program(&program);
        assert_eq!(computer.accumulator, 969);
    }
}
