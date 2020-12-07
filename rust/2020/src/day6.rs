extern crate grok;

use std::fs::read_to_string;
use std::path::Path;
use std::io::Error;
use std::collections::HashSet;

#[allow(dead_code)]
fn read_file(filename: &str) -> Result<String, Error> {
    let path = Path::new(filename);
    read_to_string(path)
}

#[allow(dead_code)]
fn split_groups(input: &String) -> Vec<Vec<String>> {
    let raw_groups = input.split("\n\n").collect::<Vec<&str>>();
    raw_groups.into_iter().map(|x| x.split("\n").map(|y| y.to_string()).filter(|z| !z.is_empty()).collect::<Vec<String>>()).collect()
}

#[allow(dead_code)]
fn build_set(response: &String) -> HashSet<char> {
    let mut answers = HashSet::new();
    for c in response.chars() {
        answers.insert(c);
    }
    answers
}

#[allow(dead_code)]
fn count_different_answer_types(group: Vec<String>) -> usize {
    let sets = group.into_iter().map(|y| build_set(&y));
    let mut result: HashSet<char> = HashSet::new();
    for set in sets {
        result = result.union(&set).cloned().collect::<HashSet<char>>();
    }
    result.len()
}

#[allow(dead_code)]
fn count_common_answer_types(group: Vec<String>) -> usize {
    let mut sets = group.into_iter().map(|y| build_set(&y));
    let mut result: HashSet<char> = sets.nth(0).unwrap();
    for set in sets {
        result = result.intersection(&set).cloned().collect::<HashSet<char>>();
    }
    result.len()
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn example1() {
        let input = read_file("day6_ex1.txt").unwrap();
        let groups = split_groups(&input);
        let answer_counts = groups.into_iter().map(|group| count_different_answer_types(group));
        assert_eq!(answer_counts.sum::<usize>(), 11);
    }

    #[test]
    fn part1() {
        let input = read_file("day6.txt").unwrap();
        let groups = split_groups(&input);
        let answer_counts = groups.into_iter().map(|group| count_different_answer_types(group));
        assert_eq!(answer_counts.sum::<usize>(), 6809);
    }

    #[test]
    fn example2() {

    }

    #[test]
    fn part2() {
        let input = read_file("day6.txt").unwrap();
        let groups = split_groups(&input);
        let answer_counts: Vec<usize> = groups.into_iter().map(|group| count_common_answer_types(group)).collect();
        // 3377 too low
        assert_eq!(answer_counts.into_iter().sum::<usize>(), 3394);
    }
}
