extern crate grok;

use std::fs::File;
use std::path::Path;
use std::io::BufRead;
use std::io::BufReader;
use std::io::Error;
use itertools::Itertools;

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
fn valid_next_number(prev: &[usize], next: usize) -> bool {
    prev.into_iter().combinations(2).any(|comb| comb[0]+comb[1] == next)
}

#[allow(dead_code)]
fn find_first_invalid(nums: &Vec<usize>, preamble: usize) -> (usize, usize) {
    for x in 0..(nums.len()-preamble) {
        if !valid_next_number(&nums[x..(x+preamble)], nums[x+preamble]) {
            return (x+preamble, nums[x+preamble]);
        }
    }
    panic!("num not found")
}

#[allow(dead_code)]
fn find_contiguous_components(nums: &[usize], target: usize) -> &[usize] {
    for x in 3.. {
        for y in 0..(nums.len()-x) {
            if nums[y..y+x-1].into_iter().sum::<usize>() == target {
                return &nums[y..y+x-1];
            }
        }
    }
    panic!("contiguous not found")
}

#[allow(dead_code)]
fn encryption_weakness(input: &[usize]) -> usize {
    let min = input.into_iter().min().unwrap();
    let max = input.into_iter().max().unwrap();
    min + max
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn valid_next_number_test() {
        let pre = (1..=25).collect::<Vec<usize>>();
        assert_eq!(valid_next_number(&pre, 26), true);
        assert_eq!(valid_next_number(&pre, 49), true);
        assert_eq!(valid_next_number(&pre, 100), false);
        assert_eq!(valid_next_number(&pre, 50), false);
    }

    #[test]
    fn example1() {
        let input_text = read_file("day9_ex1.txt").unwrap();
        let input = parse_lines(input_text);
        let first_invalid = find_first_invalid(&input, 5);
        assert_eq!(first_invalid.1, 127);
    }

    #[test]
    fn part1() {
        let input_text = read_file("day9.txt").unwrap();
        let input = parse_lines(input_text);
        let first_invalid = find_first_invalid(&input, 25);
        assert_eq!(first_invalid.1, 1212510616);
    }

    #[test]
    fn example2() {
        let input_text = read_file("day9_ex1.txt").unwrap();
        let input = parse_lines(input_text);
        let first_invalid = find_first_invalid(&input, 5);
        let contiguous_set = find_contiguous_components(&input[..first_invalid.0], first_invalid.1);
        assert_eq!(contiguous_set, vec![15, 25, 47, 40]);
        assert_eq!(encryption_weakness(contiguous_set), 62);
    }

    #[test]
    fn part2() {
        let input_text = read_file("day9.txt").unwrap();
        let input = parse_lines(input_text);
        let first_invalid = find_first_invalid(&input, 25);
        let contiguous_set = find_contiguous_components(&input[..first_invalid.0], first_invalid.1);
        assert_eq!(encryption_weakness(contiguous_set), 171265123);
    }
}
