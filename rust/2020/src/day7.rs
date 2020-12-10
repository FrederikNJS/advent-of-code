extern crate grok;

use std::fs::File;
use std::path::Path;
use std::io::BufRead;
use std::io::BufReader;
use std::io::Error;
use grok::Pattern;
use grok::Grok;
use std::collections::HashSet;
use std::collections::HashMap;
use std::collections::VecDeque;


#[allow(dead_code)]
fn read_file(filename: &str) -> Result<Vec<String>, Error> {
    let path = Path::new(filename);
    let file = File::open(&path)?;
    let reader = BufReader::new(file);
    reader.lines().filter(|line| !line.as_ref().unwrap().is_empty()).collect()
}

#[allow(dead_code)]
fn build_grokker() -> Pattern {
    let mut grok = Grok::default();
    grok.insert_definition("BAG_DESCRIPTION", "(\\w+ )+bags?");
    grok.insert_definition("BAG_COUNT", "\\d %{BAG_DESCRIPTION}");
    grok.insert_definition("NO_BAGS", "no other bags");
    grok.insert_definition("INNER_BAGS", "(%{NO_BAGS}|%{BAG_COUNT}(, %{BAG_COUNT})*)");
    grok.compile("%{BAG_DESCRIPTION:outer_bag} contain %{INNER_BAGS:inner_bags}.", false).unwrap()
}

#[allow(dead_code)]
#[derive(PartialEq, Debug, Clone)]
struct BagQuantity {
    count: usize,
    name: String,
}

#[allow(dead_code)]
#[derive(PartialEq, Debug, Clone)]
struct BagRelation {
    outer_bag: String,
    inner_bags: Vec<BagQuantity>
}

#[allow(dead_code)]
fn parse_bag(input: String) -> BagRelation {
    let outer_split: Vec<&str> = input.split(" contain ").collect();
    let outer_bag = outer_split[0].trim_end_matches('s');
    let inner = outer_split[1];
    if inner == "no other bags." {
        BagRelation {
            outer_bag: outer_bag.to_string(),
            inner_bags: vec![],
        }
    } else {
        let inner_split = inner.trim_matches('.').split(", ");
        let bag_quantities = inner_split
            .map(|t| t.splitn(2, ' ').collect::<Vec<&str>>())
            .map(|split| BagQuantity {
                count: split[0].parse::<usize>().unwrap(),
                name: split[1].trim_end_matches('s').to_string(),
            });
        BagRelation {
            outer_bag: outer_bag.to_string(),
            inner_bags: bag_quantities.collect(),
        }
    }
}

#[allow(dead_code)]
fn parse_bags(input: Vec<String>) -> Vec<BagRelation> {
    input.into_iter().map(|x| parse_bag(x)).collect()
}

#[allow(dead_code)]
fn find_all_that_could_contain(bags: &Vec<BagRelation>, start_bag: String) -> HashSet<String> {
    let mut bags_to_check = [start_bag].iter().cloned().collect::<VecDeque<String>>();
    let mut bags_checked: HashSet<String> = HashSet::new();
    let mut bags_that_could_contain = HashSet::new();
    while !bags_to_check.is_empty() {
        let current_bag = bags_to_check.pop_front().unwrap();
        bags_checked.insert(current_bag.clone());
        for bag_rel in bags.into_iter() {
            let any_match = bag_rel.inner_bags.iter().any(|bag_quan| bag_quan.name == current_bag);
            if any_match && !bags_checked.contains(&bag_rel.outer_bag) {
                bags_to_check.push_back(bag_rel.outer_bag.clone());
                bags_that_could_contain.insert(bag_rel.clone().outer_bag);
            }
        }
    }
    bags_that_could_contain
}

#[allow(dead_code)]
fn find_contained_bag_count(bags: &HashMap<String, Vec<BagQuantity>>, start_bag: String, amount: usize) -> usize {
    let inner_bags = bags[&start_bag].clone();
    inner_bags.into_iter().map(|x| find_contained_bag_count(bags, x.name, x.count)).sum::<usize>() * amount + amount
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn example1() {
        let input = read_file("day7_ex1.txt").unwrap();
        let bags = parse_bags(input);
        let all_contain = find_all_that_could_contain(&bags, "shiny gold bag".to_string());
        assert_eq!(all_contain.len(), 4);
    }

    #[test]
    fn part1() {
        let input = read_file("day7.txt").unwrap();
        let bags = parse_bags(input);
        let all_contain = find_all_that_could_contain(&bags, "shiny gold bag".to_string());
        assert_eq!(all_contain.len(), 261);
    }

    #[test]
    fn example2() {
        let input = read_file("day7_ex2.txt").unwrap();
        let bags = parse_bags(input);
        let bag_map: HashMap<String, Vec<BagQuantity>> = bags.into_iter().map(|x| (x.outer_bag, x.inner_bags)).collect();
        let all_contain = find_contained_bag_count(&bag_map, "shiny gold bag".to_string(), 1) - 1;
        assert_eq!(all_contain, 126);
    }

    #[test]
    fn part2() {
        let input = read_file("day7.txt").unwrap();
        let bags = parse_bags(input);
        let bag_map: HashMap<String, Vec<BagQuantity>> = bags.into_iter().map(|x| (x.outer_bag, x.inner_bags)).collect();
        let all_contain = find_contained_bag_count(&bag_map, "shiny gold bag".to_string(), 1) - 1;
        assert_eq!(all_contain, 3765);
    }
}
