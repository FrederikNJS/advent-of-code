extern crate grok;

use std::fs::read_to_string;
use std::path::Path;
use std::io::Error;
use std::collections::HashMap;
use grok::Grok;
use grok::Pattern;


#[allow(dead_code)]
fn read_file(filename: &str) -> Result<String, Error> {
    let path = Path::new(filename);
    read_to_string(path)
}

#[allow(dead_code)]
fn split_passports(input: &String) -> Vec<String> {
    input.split("\n\n").map(|x| x.replace("\n", " ")).filter(|x| !x.is_empty()).collect()
}

#[allow(dead_code)]
fn parse_passport(passport_string: &String) -> HashMap<String, String> {
    let mut passport = HashMap::new();
    let splits: Vec<Vec<&str>> = passport_string.split(" ").filter(|x| !x.is_empty()).map(|x| x.split(":").collect()).collect();
    for split in splits {
        passport.insert(split[0].to_string(), split[1].to_string());
    }
    passport
}

#[allow(dead_code)]
fn passport_has_valid_field_names(passport: &HashMap<String, String>) -> bool {
    let required = vec!("byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid");
    required.into_iter().all(|field| passport.contains_key(field))
}

#[allow(dead_code)]
fn valid_birth_year(byr: &String) -> bool {
    match byr.parse::<usize>() {
        Ok(y) => (1920..=2002).contains(&y),
        Err(_e) => false,
    }
}

#[allow(dead_code)]
fn valid_issue_year(iyr: &String) -> bool {
    match iyr.parse::<usize>() {
        Ok(y) => (2010..=2020).contains(&y),
        Err(_e) => false,
    }
}

#[allow(dead_code)]
fn valid_expiration_year(eyr: &String) -> bool {
    match eyr.parse::<usize>() {
        Ok(y) => (2020..=2030).contains(&y),
        Err(_e) => false,
    }
}

struct Grokker{
    height: Pattern,
    hair: Pattern,
    eyes: Pattern,
    passport_id: Pattern
}

#[allow(dead_code)]
fn build_grokker() -> Grokker {
    let mut grok = Grok::default();
    grok.insert_definition("NUMBER", "[0-9]{2,3}");
    grok.insert_definition("UNIT", "(in|cm)");

    Grokker {
        height: grok.compile("%{NUMBER:number}%{UNIT:unit}$", false).unwrap(),
        hair: grok.compile("#[0-9a-f]{6}$", false).unwrap(),
        eyes: grok.compile("(amb|blu|brn|gry|grn|hzl|oth)$", false).unwrap(),
        passport_id: grok.compile("[0-9]{9}$", false).unwrap(),
    }
}

#[allow(dead_code)]
fn valid_height(grokker: &Grokker, hgt: &String) -> bool {
    match grokker.height.match_against(hgt) {
        Some(m) => {
            let unit = m.get("unit").unwrap();
            let number = m.get("number").unwrap();
            match unit {
                "cm" => (150..=193).contains(&number.parse::<usize>().unwrap()),
                "in" => (59..=76).contains(&number.parse::<usize>().unwrap()),
                _ => false,
            }
        },
        None => {
            false
        },
    }
}

#[allow(dead_code)]
fn valid_hair(grokker: &Grokker, hcl: &String) -> bool {
    match grokker.hair.match_against(hcl) {
        Some(_m) => true,
        None => false,
    }
}

#[allow(dead_code)]
fn valid_eyes(grokker: &Grokker, ecl: &String) -> bool {
    match grokker.eyes.match_against(ecl) {
        Some(_m) => true,
        None => false,
    }
}

#[allow(dead_code)]
fn valid_passport_id(grokker: &Grokker, pid: &String) -> bool {
    match grokker.passport_id.match_against(pid) {
        Some(_m) => pid.len() == 9,
        None => false,
    }
}

#[allow(dead_code)]
fn passport_is_valid(grokker: &Grokker, passport: &HashMap<String, String>) -> bool {
    passport_has_valid_field_names(passport) &&
        valid_birth_year(&passport["byr"]) &&
        valid_issue_year(&passport["iyr"]) &&
        valid_expiration_year(&passport["eyr"]) &&
        valid_height(&grokker, &passport["hgt"]) &&
        valid_hair(&grokker, &passport["hcl"]) &&
        valid_eyes(&grokker, &passport["ecl"]) &&
        valid_passport_id(&grokker, &passport["pid"])
}

#[cfg(test)]
mod tests {
    use super::*;



    #[test]
    fn example1() {
        let input = read_file("day4_ex1.txt").unwrap();
        let passport_strings = split_passports(&input);
        let passports = passport_strings.into_iter().map(|passport_string| parse_passport(&passport_string));
        let valid_passports = passports.filter(|passport| passport_has_valid_field_names(&passport));
        assert_eq!(valid_passports.count(), 2);
    }

    #[test]
    fn part1() {
        let input = read_file("day4.txt").unwrap();
        let passport_strings = split_passports(&input);
        let passports = passport_strings.into_iter().map(|passport_string| parse_passport(&passport_string));
        let valid_passports = passports.filter(|passport| passport_has_valid_field_names(&passport));
        assert_eq!(valid_passports.count(), 190);
    }

    #[test]
    fn byr_test() {
        assert_eq!(valid_birth_year(&"2002".to_string()), true);
        assert_eq!(valid_birth_year(&"2003".to_string()), false);
        assert_eq!(valid_birth_year(&"1919".to_string()), false);
        assert_eq!(valid_birth_year(&"1920".to_string()), true);
    }

    #[test]
    fn hgt_test() {
        let grokker = build_grokker();
        assert_eq!(valid_height(&grokker, &"50".to_string()), false);
        assert_eq!(valid_height(&grokker, &"50in".to_string()), false);
        assert_eq!(valid_height(&grokker, &"59".to_string()), false);
        assert_eq!(valid_height(&grokker, &"58in".to_string()), false);
        assert_eq!(valid_height(&grokker, &"59in".to_string()), true);
        assert_eq!(valid_height(&grokker, &"76in".to_string()), true);
        assert_eq!(valid_height(&grokker, &"77in".to_string()), false);
        assert_eq!(valid_height(&grokker, &"149cm".to_string()), false);
        assert_eq!(valid_height(&grokker, &"150cm".to_string()), true);
        assert_eq!(valid_height(&grokker, &"193cm".to_string()), true);
        assert_eq!(valid_height(&grokker, &"194cm".to_string()), false);
        assert_eq!(valid_height(&grokker, &"193".to_string()), false);
        assert_eq!(valid_height(&grokker, &"150".to_string()), false);
    }

    #[test]
    fn hcl_test() {
        let grokker = build_grokker();
        assert_eq!(valid_hair(&grokker, &"#123abc".to_string()), true);
        assert_eq!(valid_hair(&grokker, &"#123abz".to_string()), false);
        assert_eq!(valid_hair(&grokker, &"123abc".to_string()), false);
    }

    #[test]
    fn ecl_test() {
        let grokker = build_grokker();
        assert_eq!(valid_eyes(&grokker, &"brn".to_string()), true);
        assert_eq!(valid_eyes(&grokker, &"wat".to_string()), false);
    }

    #[test]
    fn pid_test() {
        let grokker = build_grokker();
        assert_eq!(valid_passport_id(&grokker, &"000000001".to_string()), true);
        assert_eq!(valid_passport_id(&grokker, &"0123456789".to_string()), false);
    }

    #[test]
    fn example2() {
        let grokker = build_grokker();
        let input = read_file("day4_ex2.txt").unwrap();
        let passport_strings = split_passports(&input);
        let passports = passport_strings.into_iter().map(|passport_string| parse_passport(&passport_string));
        let valid_passports = passports.filter(|passport| passport_is_valid(&grokker, passport));
        assert_eq!(valid_passports.count(), 4);
    }

    #[test]
    fn part2() {
        let grokker = build_grokker();
        let input = read_file("day4.txt").unwrap();
        let passport_strings = split_passports(&input);
        let passports = passport_strings.into_iter().map(|passport_string| parse_passport(&passport_string));
        let valid_passports = passports.filter(|passport| passport_is_valid(&grokker, passport));
        // 122 too high
        assert_eq!(valid_passports.count(), 121);
    }
}
