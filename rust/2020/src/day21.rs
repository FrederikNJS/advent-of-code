extern crate grok;

use std::fs::File;
use std::path::Path;
use std::io::BufRead;
use std::io::BufReader;
use std::io::Error;
use std::collections::HashSet;

#[allow(dead_code)]
fn read_file(filename: &str) -> Result<Vec<String>, Error> {
    let path = Path::new(filename);
    let file = File::open(&path)?;
    let reader = BufReader::new(file);
    reader.lines().filter(|line| !line.as_ref().unwrap().is_empty()).collect()
}

type Ingredient = String;
type Allergen = String;

#[allow(dead_code)]
#[derive(Clone)]
struct Recipe {
    ingredients: Vec<Ingredient>,
    guaranteed_allergens: Vec<Allergen>,
}

#[allow(dead_code)]
fn parse_recipe(line: String) -> Recipe {
    let initial_split = line.split(" (contains ").into_iter().collect::<Vec<&str>>();
    let ingredients = initial_split[0].split(' ').map(|x| x.to_string()).collect::<Vec<Ingredient>>();
    let guaranteed_allergens = initial_split[1].trim_matches(')').split(", ").map(|x| x.to_string()).collect::<Vec<Allergen>>();
    Recipe {
        ingredients: ingredients,
        guaranteed_allergens: guaranteed_allergens,
    }
}

#[allow(dead_code)]
fn collect_all_allergens(recipes: Vec<Recipe>) -> HashSet<String> {
    let mut allergens = HashSet::new();
    for recipe in recipes {
        for allergen in recipe.guaranteed_allergens {
            allergens.insert(allergen);
        }
    }
    allergens
}



#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_mask_number() {
    }

    #[test]
    fn example1() {
    }

    #[test]
    fn part1() {
    }

    #[test]
    fn example2() {

    }

    #[test]
    fn part2() {

    }
}
