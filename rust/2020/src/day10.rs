extern crate grok;

use std::fs::File;
use std::path::Path;
use std::io::BufRead;
use std::io::BufReader;
use std::io::Error;
use itertools::Itertools; //actually used for `.sorted()`.
use std::collections::HashMap;


#[allow(dead_code)]
fn read_file(filename: &str) -> Result<Vec<String>, Error> {
    let path = Path::new(filename);
    let file = File::open(&path)?;
    let reader = BufReader::new(file);
    reader.lines().filter(|line| !line.as_ref().unwrap().is_empty()).collect()
}

#[allow(dead_code)]
fn parse_lines(lines: Vec<String>) -> Vec<usize> {
    lines.into_iter().map(|x| x.parse::<usize>().unwrap()).collect()
}

#[allow(dead_code)]
fn find_built_in_joltage(adapters: &Vec<usize>) -> usize {
    adapters.into_iter().max().unwrap() + 3
}

#[allow(dead_code)]
fn pretty_print_path_map(path_map: &HashMap<usize, usize>) {
    path_map.into_iter().sorted().for_each(|(key, value)| println!("        {}    {}", key, value))
}

#[allow(dead_code)]
fn build_possible_paths(input: &Vec<usize>) -> HashMap<usize, usize> {
    let mut path_map: HashMap<usize, usize> = HashMap::new();
    path_map.insert(0, 1);
    for current in input {
        let a = if path_map.contains_key(&(current-1)) {path_map[&(current-1)]} else {0};
        let b = if path_map.contains_key(&(current-2)) {path_map[&(current-2)]} else {0};
        let c = if path_map.contains_key(&(current-3)) {path_map[&(current-3)]} else {0};
        path_map.insert(*current, a+b+c);
    }
    path_map
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn find_built_in_joltage_test() {
        let input_text = read_file("day10_ex1.txt").unwrap();
        let input = parse_lines(input_text);
        let joltage = find_built_in_joltage(&input);
        assert_eq!(joltage, 22);
    }

    #[test]
    fn example1() {
        let input_text = read_file("day10_ex1.txt").unwrap();
        let input = parse_lines(input_text);
        let sorted = input.into_iter().sorted().collect::<Vec<usize>>();
        let mut one_diff = 1;
        let mut three_diff = 1;
        for x in 0..(sorted.len()-1) {
            match sorted[x+1] - sorted[x] {
                1 => one_diff += 1,
                3 => three_diff += 1,
                _ => ()
            }
        }
        assert_eq!(one_diff, 7);
        assert_eq!(three_diff, 5);
        assert_eq!(one_diff * three_diff, 35);
    }

    #[test]
    fn example2() {
        let input_text = read_file("day10_ex2.txt").unwrap();
        let input = parse_lines(input_text);
        let sorted = input.into_iter().sorted().collect::<Vec<usize>>();
        let mut one_diff = 1;
        let mut three_diff = 1;
        for x in 0..(sorted.len()-1) {
            match sorted[x+1] - sorted[x] {
                1 => one_diff += 1,
                3 => three_diff += 1,
                _ => ()
            }
        }
        assert_eq!(one_diff, 22);
        assert_eq!(three_diff, 10);
        assert_eq!(one_diff * three_diff, 220);
    }

    #[test]
    fn part1() {
        let input_text = read_file("day10.txt").unwrap();
        let input = parse_lines(input_text);
        let sorted = input.into_iter().sorted().collect::<Vec<usize>>();
        let mut one_diff = 1;
        let mut three_diff = 1;
        for x in 0..(sorted.len()-1) {
            match sorted[x+1] - sorted[x] {
                1 => one_diff += 1,
                3 => three_diff += 1,
                _ => ()
            }
        }
        assert_eq!(one_diff, 69);
        assert_eq!(three_diff, 40);
        assert_eq!(one_diff * three_diff, 2760);
    }

    #[test]
    fn example3() {
        let input_text = read_file("day10_ex1.txt").unwrap();
        let mut input = parse_lines(input_text);
        input.push(find_built_in_joltage(&input));
        let sorted = input.into_iter().sorted().collect::<Vec<usize>>();
        let possible_paths = build_possible_paths(&sorted);
        assert_eq!(*possible_paths.values().max().unwrap(), 8);
    }

    #[test]
    fn example4() {
        let input_text = read_file("day10_ex2.txt").unwrap();
        let mut input = parse_lines(input_text);
        input.push(find_built_in_joltage(&input));
        let sorted = input.into_iter().sorted().collect::<Vec<usize>>();
        let possible_paths = build_possible_paths(&sorted);
        assert_eq!(*possible_paths.values().max().unwrap(), 19208);
    }

    #[test]
    fn part2() {
        let input_text = read_file("day10.txt").unwrap();
        let mut input = parse_lines(input_text);
        input.push(find_built_in_joltage(&input));
        let sorted = input.into_iter().sorted().collect::<Vec<usize>>();
        let possible_paths = build_possible_paths(&sorted);
        assert_eq!(*possible_paths.values().max().unwrap(), 13816758796288);
    }
}
