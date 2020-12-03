extern crate grok;

use std::fs::File;
use std::path::Path;
use std::io::BufRead;
use std::io::BufReader;
use std::io::Error;
use itertools::Itertools;
use grok::Grok;
use std::iter::Map;

#[allow(dead_code)]
fn read_file() -> Result<Vec<String>, Error> {
    let path = Path::new("day2.txt");
    let file = File::open(&path)?;
    let reader = BufReader::new(file);
    reader.lines().collect()
}

#[derive(PartialEq, Debug)]
struct DatabaseEntry {
    min: usize,
    max: usize,
    character: char,
    password: String,
}

#[allow(dead_code)]
fn parse_db(list: Vec<String>) -> Vec<DatabaseEntry> {
    let mut grok = Grok::default();
    grok.insert_definition("CHAR", "[a-z]");
    let pattern = grok.compile("%{POSINT:min}-%{POSINT:max} %{CHAR:character}: %{WORD:password}", false).expect("Failed compiling grok");
    let mut database_entries = Vec::new();
    for entry in list {
        match pattern.match_against(&entry) {
            Some(m) => {
                database_entries.push(DatabaseEntry {
                    min: m.get("min").unwrap().parse::<usize>().unwrap(),
                    max: m.get("max").unwrap().parse::<usize>().unwrap(),
                    character: m.get("character").unwrap().chars().nth(0).unwrap(),
                    password: m.get("password").unwrap().to_string() }
                )
            },
            None => continue
        }
    }
    database_entries
}

#[allow(dead_code)]
fn exjob_validate_entry(entry: &DatabaseEntry) -> bool {
    let char_count = entry.password.chars().filter(|c| *c == entry.character).count();
    char_count >= entry.min && char_count <= entry.max
}

#[allow(dead_code)]
fn newjob_validate_entry(entry: &DatabaseEntry) -> bool {

    let first_pos = entry.min <= entry.password.len() && entry.password.chars().nth(entry.min-1).unwrap() == entry.character;
    let second_pos = entry.max <= entry.password.len() && entry.password.chars().nth(entry.max-1).unwrap() == entry.character;
    first_pos ^ second_pos
}

#[cfg(test)]
mod tests {
    // Note this useful idiom: importing names from outer (for mod tests) scope.
    use super::*;

    #[test]
    fn parse() {
        let input = vec!["1-2 a: password".to_string(), "3-4 b: hunter2".to_string()];
        let database_entries = parse_db(input);
        let expected = vec![
            DatabaseEntry { min: 1, max: 2, character: 'a', password: "password".to_string() },
            DatabaseEntry { min: 3, max: 4, character: 'b', password: "hunter2".to_string() },
        ];
        assert_eq!(database_entries, expected);
    }

    #[test]
    fn part1() {
        let contents = read_file().unwrap();
        let db_entries = parse_db(contents);
        let valid_entries = db_entries.into_iter().filter(|entry| exjob_validate_entry(entry));
        println!("valid entries (old job): {}", valid_entries.count())
    }

    #[test]
    fn part2() {
        let contents = read_file().unwrap();
        let db_entries = parse_db(contents);
        let valid_entries = db_entries.into_iter().filter(|entry| newjob_validate_entry(entry));
        println!("valid entries (new job): {}", valid_entries.count())
    }
}
