use std::fs::File;
use std::path::Path;
use std::io::BufRead;
use std::io::BufReader;
use std::io::Error;
use itertools::Itertools;

#[allow(dead_code)]
fn read_file() -> Result<Vec<String>, Error> {
    let path = Path::new("day1.txt");
    let file = File::open(&path)?;
    let reader = BufReader::new(file);
    reader.lines().filter(|line| !line.as_ref().unwrap().is_empty()).collect()
}

#[allow(dead_code)]
fn parse_number_vec(list: impl Iterator<Item=String>) -> impl Iterator<Item=i32> {
    list.map(|x| x.parse::<i32>().expect("not a number"))
}

#[allow(dead_code)]
fn find_x_that_sum_to(numbers: impl Iterator<Item=i32>, choices: usize, target: i32) -> Vec<i32> {
    let combinations = numbers.combinations(choices);
    combinations.into_iter().find(|comb| comb.into_iter().sum::<i32>() == target).unwrap().to_vec()
}

#[cfg(test)]
mod tests {
    // Note this useful idiom: importing names from outer (for mod tests) scope.
    use super::*;

    #[test]
    fn part1() {
        let list = read_file().unwrap();
        let numbers = parse_number_vec(list.iter().cloned());
        let components = find_x_that_sum_to(numbers, 2, 2020);
        let product = components.iter().fold(1, |sum, x| sum * x);
        println!("{:?}", components);
        println!("product {}", product);
        assert_eq!(product, 691771);
    }

    #[test]
    fn part2() {
        let list = read_file().unwrap();
        let numbers = parse_number_vec(list.iter().cloned());
        let components = find_x_that_sum_to(numbers, 3, 2020);
        let product = components.iter().fold(1, |sum, x| sum * x);
        println!("{:?}", components);
        println!("product {}", product);
        assert_eq!(product, 232508760);
    }
}
