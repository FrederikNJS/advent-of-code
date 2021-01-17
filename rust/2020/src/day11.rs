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
fn parse_grid(lines: Vec<String>) -> Vec<Vec<char>> {
    lines.into_iter().map(|line| line.chars().collect::<Vec<char>>()).collect()
}

#[allow(dead_code)]
fn step(grid: &Vec<Vec<char>>) -> Vec<Vec<char>> {
    let mut new_grid: Vec<Vec<char>> = vec![vec![' '; grid[0].len()]; grid.len()];
    for y in 0..grid.len() {
        for x in 0..grid[0].len() {
            let neighbors = vec![
                if y >= 1 && x >= 1 {grid[y-1][x-1]} else {'.'},
                if y >= 1 {grid[y-1][x]} else {'.'},
                if y >= 1 && x+1 < grid[0].len() {grid[y-1][x+1]} else {'.'},
                if x >= 1 {grid[y][x-1]} else {'.'},
                if x+1 < grid[0].len() {grid[y][x+1]} else {'.'},
                if y+1 < grid.len() && x >= 1 {grid[y+1][x-1]} else {'.'},
                if y+1 < grid.len() {grid[y+1][x]} else {'.'},
                if y+1 < grid.len() && x+1 < grid[0].len() {grid[y+1][x+1]} else {'.'},
            ];
            let current = grid[y][x];
            new_grid[y][x] = if current == 'L' && neighbors.clone().into_iter().filter(|x| *x == '#').count() == 0 {
                '#'
            } else if current == '#' && neighbors.clone().into_iter().filter(|x| *x == '#').count() > 3 {
                'L'
            } else {
                grid[y][x]
            }
        }
    }
    new_grid
}

//fn ray_cast(x: usize, y: usize, x_delta: isize, y_delta: isize) ->

#[allow(dead_code)]
fn pretty_print_grid(grid: &Vec<Vec<char>>) {
    for row in grid {
        println!("{}", row.into_iter().collect::<String>())
    }
}

#[allow(dead_code)]
fn count_occupied(grid: Vec<Vec<char>>) -> usize {
    grid.into_iter().map(|row| row.into_iter().filter(|x| *x == '#').count() ).sum::<usize>()
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn step_test() {
        let raw_input = read_file("day11_ex1.txt");
        let input = parse_grid(raw_input.unwrap());
        let step1 = step(&input);
        let step2 = step(&step1);
        let step3 = step(&step2);
        let step4 = step(&step3);
        let step5 = step(&step4);
        let step6 = step(&step5);
        assert_ne!(step4, step5);
        assert_eq!(step5, step6);
    }

    #[test]
    fn example1() {
        let raw_input = read_file("day11_ex1.txt");
        let input = parse_grid(raw_input.unwrap());
        let mut old = step(&input);
        loop {
            let new = step(&old);
            if new == old {break}
            old = new;
        }
        assert_eq!(count_occupied(old), 37);
    }

    #[test]
    fn part1() {
        let raw_input = read_file("day11.txt");
        let input = parse_grid(raw_input.unwrap());
        let mut old = step(&input);
        loop {
            let new = step(&old);
            if new == old {break}
            old = new;
        }
        assert_eq!(count_occupied(old), 2281);
    }

    #[test]
    fn example2() {

    }

    #[test]
    fn part2() {

    }
}
