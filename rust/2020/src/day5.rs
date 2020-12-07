extern crate grok;

use std::fs::File;
use std::path::Path;
use std::io::BufRead;
use std::io::BufReader;
use std::io::Error;

#[allow(dead_code)]
fn read_file(filename: &str) -> Result<Vec<String>, Error> {
    let path = Path::new(filename);
    let file = File::open(&path)?;
    let reader = BufReader::new(file);
    reader.lines().filter(|line| !line.as_ref().unwrap().is_empty()).collect()
}

#[allow(dead_code)]
fn parse_row(seat_string: &String) -> usize {
    let mut min = 0;
    let mut max = 127;
    for char in seat_string[..7].chars() {
        match char {
            'F' => {
                max = (min + max) / 2;
            },
            'B' => {
                min = ((min + max) - 1) / 2 + 1;
            },
            _ => (),
        }
    }
    min
}

#[allow(dead_code)]
fn parse_column(seat_string: &String) -> usize {
    let mut min = 0;
    let mut max = 7;
    for char in seat_string[7..].chars() {
        match char {
            'L' => {
                max = (min + max) / 2;
            },
            'R' => {
                min = ((min + max) - 1) / 2 + 1;
            },
            _ => (),
        }
    }
    min
}

#[allow(dead_code)]
fn convert_to_seat_id(row: usize, column: usize) -> usize {
    row * 8 + column
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn example1() {
        assert_eq!(parse_row(&"FBFBBFFRLR".to_string()), 44);
        assert_eq!(parse_column(&"FBFBBFFRLR".to_string()), 5);
    }

    #[test]
    fn part1() {
        let input = read_file("day5.txt").unwrap();
        let max = input.into_iter().map(|x| convert_to_seat_id(parse_row(&x), parse_column(&x))).max().unwrap();
        assert_eq!(max, 965);
    }

    #[test]
    fn part2() {
        let mut seats = [[false; 8]; 128];
        let input = read_file("day5.txt").unwrap();
        for boarding_pass in input {
            seats[parse_row(&boarding_pass)][parse_column(&boarding_pass)] = true
        }
        let mut row_num = 128;
        let mut col_num = 8;
        for (i, row) in seats.iter().enumerate() {
            if row.iter().filter(|x| **x == false).count() == 1 {
                row_num = i;
                col_num = row.iter().position(|y| *y == false).unwrap();
            }
        }
        let seat_id = convert_to_seat_id(row_num, col_num);
        assert_eq!(seat_id, 524);
    }
}
