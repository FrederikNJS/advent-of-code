extern crate grok;

use std::fs::File;
use std::path::Path;
use std::io::BufRead;
use std::io::BufReader;
use std::io::Error;
use std::collections::HashMap;
use grok::Grok;
use grok::Pattern;

#[allow(dead_code)]
fn read_file(filename: &str) -> Result<Vec<String>, Error> {
    let path = Path::new(filename);
    let file = File::open(&path)?;
    let reader = BufReader::new(file);
    reader.lines().filter(|line| !line.as_ref().unwrap().is_empty()).collect()
}

#[allow(dead_code)]
enum Instruction {
    Mask {
        mask: usize,
        pos_mask: usize,
    },
    Set {
        address: usize,
        value: usize,
    }
}

#[allow(dead_code)]
fn parse_instruction(raw_instruction: &str) -> Option<Instruction> {
    if raw_instruction.starts_with("mask") {
        parse_mask(raw_instruction)
    } else if raw_instruction.starts_with("mem") {
        parse_set(raw_instruction)
    } else {
        None
    }
}

fn parse_mask(raw_instruction: &str) -> Option<Instruction> {
    lazy_static! {
        static ref GROK: Pattern = {
            let mut grok = Grok::default();
            grok.insert_definition("MASK", "[01X]+");
            grok.compile(r"mask = %{MASK:mask}$", false).unwrap()
        };
    }

    match GROK.match_against(raw_instruction) {
        Some(m) => {
            let raw_mask = m.get("mask").unwrap();
            let pos_mask = usize::from_str_radix(&raw_mask.replace('0', "1").replace('X', "0"), 2).unwrap();
            let mask = usize::from_str_radix(&raw_mask.replace('X', "0"), 2).unwrap();
            Some(Instruction::Mask {
                mask: mask,
                pos_mask: pos_mask
            })
        }
        None => None
    }
}

fn parse_set(raw_instruction: &str) -> Option<Instruction> {
    lazy_static! {
        static ref GROK: Pattern = {
            let mut grok = Grok::default();
            grok.compile(r"mem\[%{INT:address}\] = %{INT:value}$", false).unwrap()
        };
    }
    match GROK.match_against(raw_instruction) {
        Some(m) => {
            let raw_address = m.get("address").unwrap();
            let raw_value = m.get("value").unwrap();
            Some(Instruction::Set {
                address: raw_address.parse::<usize>().unwrap(),
                value: raw_value.parse::<usize>().unwrap()
            })
        }
        None => None
    }
}

#[allow(dead_code)]
fn mask_number(value: usize, mask: usize, pos_mask: usize) -> usize {
    let mut result = value;
    for pos in 0..36 {
        if pos_mask & (1 << pos) != 0 {
            let mask_target = 1 << pos;
            let single_mask = mask_target & mask;
            if single_mask == 0 {
                result = result & !mask_target;
            } else {
                result = result | mask_target;
            }
            //println!("{:b}, {:b}, {:b}", result, mask_target, single_mask);
        }
    }
    result
}

#[allow(dead_code)]
fn process_program(program: Vec<Instruction>) -> HashMap<usize, usize> {
    let mut current_mask = 0b0;
    let mut current_pos_mask = 0b0;
    let mut memory = HashMap::new();

    for instruction in program {
        match instruction {
            Instruction::Mask { mask, pos_mask } => {
                current_mask = mask;
                current_pos_mask = pos_mask;
            },
            Instruction::Set { address, value } => {
                memory.insert(address, mask_number(value, current_mask, current_pos_mask));
            }
        }
    }

    memory
}

#[allow(dead_code)]
fn sum_memory(memory: HashMap<usize, usize>) -> usize {
    memory.values().sum()
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_mask_number() {
        assert_eq!(mask_number(11, 0b1000000, 0b1000010), 73);
        assert_eq!(mask_number(101, 0b1000000, 0b1000010), 101);
        assert_eq!(mask_number(0, 0b1000000, 0b1000010), 64);
    }

    #[test]
    fn example1() {
        let ex_program = vec![
            Instruction::Mask {
                mask: 0b1000000,
                pos_mask: 0b1000010
            },
            Instruction::Set {
                address: 8,
                value: 11
            },
            Instruction::Set {
                address: 7,
                value: 101
            },
            Instruction::Set {
                address: 8,
                value: 0
            },
        ];

        let memory = process_program(ex_program);
        assert_eq!(memory.values().len(), 2);
        assert_eq!(memory.get(&(7 as usize)).unwrap(), &(101 as usize));
        assert_eq!(memory.get(&(8 as usize)).unwrap(), &(64 as usize));

        let memory_sum = sum_memory(memory);
        assert_eq!(memory_sum, 165 as usize);
    }

    #[test]
    fn part1() {
        let raw_program = read_file("day14.txt").unwrap();
        let program = raw_program.into_iter().filter_map(|line| parse_instruction(&line)).collect::<Vec<Instruction>>();
        let memory = process_program(program);
        let memory_sum = sum_memory(memory);
        assert_eq!(memory_sum, 6386593869035);
    }

    #[test]
    fn example2() {

    }

    #[test]
    fn part2() {

    }
}
