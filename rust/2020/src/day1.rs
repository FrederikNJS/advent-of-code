use std::fs::File;
use std::path::Path;
use std::io::BufRead;
use std::io::BufReader;
use std::io::Error;
use itertools::Itertools;

#[allow(dead_code)]
fn read_file() -> Result<Vec<String>, Error> {
    let path = Path::new("day1.txt");
    let file = File::open(&path).expect("file not found!");
    let reader = BufReader::new(file);
    reader.lines().collect()
}

#[allow(dead_code)]
fn parse_number_vec(list: Vec<String>) -> Vec<i32> {
    list.iter().map(|x| x.parse::<i32>().expect("not a number")).collect()
}

#[allow(dead_code)]
fn find_x_that_sum_to(numbers: Vec<i32>, choices: usize, target: i32) -> Vec<i32> {
    let combinations: Vec<Vec<i32>> = numbers.iter().cloned().combinations(choices).collect();
    combinations.iter().find(|comb| comb.iter().cloned().sum::<i32>() == target).unwrap().to_vec()
}

#[cfg(test)]
mod tests {
    // Note this useful idiom: importing names from outer (for mod tests) scope.
    use super::*;

    #[test]
    fn part1() {
        let list = read_file().unwrap();
        let numbers = parse_number_vec(list);
        let components = find_x_that_sum_to(numbers, 2, 2020);
        println!("{:?}", components);
        println!("product {}", components.iter().fold(1, |sum, x| sum * x));
    }

    #[test]
    fn part2() {
        let list = read_file().unwrap();
        let numbers = parse_number_vec(list);
        let components = find_x_that_sum_to(numbers, 3, 2020);
        println!("{:?}", components);
        println!("product {}", components.iter().fold(1, |sum, x| sum * x));
    }
}
