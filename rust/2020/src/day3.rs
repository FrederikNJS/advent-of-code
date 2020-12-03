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
fn strings_to_2d_grid(strings: &Vec<String>) -> Vec<Vec<char>> {
    strings.into_iter().map(|string| string.chars().collect()).collect()
}

#[allow(dead_code)]
fn grid_index(grid: &Vec<Vec<char>>, coord: (usize, usize)) -> char {
    grid[coord.1][coord.0 % grid[0].len()]
}

#[allow(dead_code)]
fn gen_index_seq(x: usize, y: usize, max_y: usize) -> Vec<(usize, usize)> {
    let mut seq = Vec::new();
    for (n, y) in (y..max_y).step_by(y).enumerate() {
        seq.push(((n+1)*x, y));
    }

    //[(2, 2), (4, 4), (6, 6), (8, 8), (10, 10)]
    //[(2, 1), (4, 2), (6, 3), (8, 4), (10, 5)]
    seq
}

#[allow(dead_code)]
fn index_sec_to_values(grid: &Vec<Vec<char>>, seq: Vec<(usize, usize)>) -> Vec<char> {
    let mut values = Vec::new();
    for coord in seq {
        values.push(grid_index(&grid, coord));
    }
    values
}

#[allow(dead_code)]
fn count_trees(values: Vec<char>) -> usize {
    values.into_iter().filter(|&x| x == '#').count()
}

#[cfg(test)]
mod tests {
    // Note this useful idiom: importing names from outer (for mod tests) scope.
    use super::*;

    #[test]
    fn example1() {
        let contents = read_file("day3_ex1.txt").unwrap();
        let grid = strings_to_2d_grid(&contents);
        let seq = gen_index_seq(3, 1, contents.len());
        let values = index_sec_to_values(&grid, seq);
        let trees = count_trees(values);
        assert_eq!(trees, 7)
    }

    #[test]
    fn part1() {
        let contents = read_file("day3.txt").unwrap();
        let grid = strings_to_2d_grid(&contents);
        let seq = gen_index_seq(3, 1, contents.len());
        let values = index_sec_to_values(&grid, seq);
        let trees = count_trees(values);
        assert_eq!(trees, 240)
    }

    #[test]
    fn example2() {
        let contents = read_file("day3_ex1.txt").unwrap();
        let grid = strings_to_2d_grid(&contents);
        let slopes = vec!(
            (1, 1),
            (3, 1),
            (5, 1),
            (7, 1),
            (1, 2)
        );
        let mut total_trees = 1;
        for slope in slopes {
            let seq = gen_index_seq(slope.0, slope.1, contents.len());
            //println!("{:?}", seq);
            let values = index_sec_to_values(&grid, seq);
            //println!("{:?}", values);
            let trees = count_trees(values);
            //println!("{}", trees);
            total_trees *= trees;
        }
        assert_eq!(total_trees, 336)
    }

    #[test]
    fn part2() {
        let contents = read_file("day3.txt").unwrap();
        let grid = strings_to_2d_grid(&contents);
        let slopes = vec!(
            (1, 1),
            (3, 1),
            (5, 1),
            (7, 1),
            (1, 2)
        );
        let mut total_trees = 1;
        for slope in slopes {
            let seq = gen_index_seq(slope.0, slope.1, contents.len());
            let values = index_sec_to_values(&grid, seq);
            let trees = count_trees(values);
            //println!("{}", trees);
            total_trees *= trees;
        }
        assert_eq!(total_trees, 2832009600)
    }
}
