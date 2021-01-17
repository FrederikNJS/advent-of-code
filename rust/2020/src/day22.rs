extern crate grok;

use std::fs::File;
use std::path::Path;
use std::io::BufRead;
use std::io::BufReader;
use std::io::Error;
use std::collections::VecDeque;
use std::collections::HashSet;


#[allow(dead_code)]
fn read_file(filename: &str) -> Result<Vec<String>, Error> {
    let path = Path::new(filename);
    let file = File::open(&path)?;
    let reader = BufReader::new(file);
    reader.lines().filter(|line| !line.as_ref().unwrap().is_empty()).collect()
}

#[allow(dead_code)]
fn play_round(p1: &mut VecDeque<usize>, p2: &mut VecDeque<usize>) {
    let p1_play = p1.pop_front().unwrap();
    let p2_play = p2.pop_front().unwrap();

    if p1_play > p2_play {
        p1.push_back(p1_play);
        p1.push_back(p2_play);
    } else if p1_play < p2_play {
        p2.push_back(p2_play);
        p2.push_back(p1_play);
    } else {
        println!("WAT!")
    }
}

#[allow(dead_code)]
fn play_recursive_round(p1: &mut VecDeque<usize>, p2: &mut VecDeque<usize>, game_num: usize, _round_num: usize) {
    //println!("Game: {}, Round: {}\np1: {:?}\np2: {:?}\n\n", game_num, round_num, p1, p2);
    let p1_play = p1.pop_front().unwrap();
    let p2_play = p2.pop_front().unwrap();

    if p1.len() >= p1_play && p2.len() >= p2_play {
        let mut new_p1 = p1.clone();
        new_p1.truncate(p1_play);
        let mut new_p2 = p2.clone();
        new_p2.truncate(p2_play);
        play_recursive_game(&mut new_p1, &mut new_p2, game_num+1);
        if new_p1.len() > new_p2.len() {
            p1.push_back(p1_play);
            p1.push_back(p2_play);
        } else if new_p2.len() > new_p1.len() {
            p2.push_back(p2_play);
            p2.push_back(p1_play);
        } else {
            println!("deep WAT");
        }
    } else if p1_play > p2_play {
        p1.push_back(p1_play);
        p1.push_back(p2_play);
    } else if p1_play < p2_play {
        p2.push_back(p2_play);
        p2.push_back(p1_play);
    } else {
        println!("WAT!")
    }
}

#[allow(dead_code)]
fn calculate_score(deck: &VecDeque<usize>) -> usize {
    deck.into_iter().rev().enumerate().map(|(a, b)| (a+1) * b).sum()
}

#[allow(dead_code)]
fn play_game(p1: &mut VecDeque<usize>, p2: &mut VecDeque<usize>) -> usize {
    while p1.len() > 0 && p2.len() > 0 {
        play_round(p1, p2)
    }
    if p1.len() > 0 {
        calculate_score(p1)
    } else if p2.len() > 0 {
        calculate_score(p2)
    } else {
        0
    }
}

fn play_recursive_game(p1: &mut VecDeque<usize>, p2: &mut VecDeque<usize>, game_num: usize) {
    let mut round_num = 0;
    let mut game_memory: HashSet<(VecDeque<usize>, VecDeque<usize>)> = HashSet::new();
    while p1.len() > 0 && p2.len() > 0 {
        if game_memory.contains(&(p1.clone(), p2.clone())) {
            p2.truncate(0);
            return
        } else {
            game_memory.insert((p1.clone(), p2.clone()));
        }
        round_num = round_num + 1;
        play_recursive_round(p1, p2, game_num, round_num);
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn example1() {
        let mut p1 = vec![9,2,6,3,1].into_iter().collect::<VecDeque<usize>>();
        let mut p2 = vec![5,8,4,7,10].into_iter().collect::<VecDeque<usize>>();
        let result = play_game(&mut p1, &mut p2);
        assert_eq!(result, 306);
    }

    #[test]
    fn part1() {
        let mut p1 = vec![29,21,38,30,25,7,2,36,16,44,20,12,45,4,31,34,33,42,50,14,39,37,11,43,18].into_iter().collect::<VecDeque<usize>>();
        let mut p2 = vec![32,24,10,41,13,3,6,5,9,8,48,49,46,17,22,35,1,19,23,28,40,26,47,15,27].into_iter().collect::<VecDeque<usize>>();
        let result = play_game(&mut p1, &mut p2);
        assert_eq!(result, 32677);
    }

    #[test]
    fn example2() {
        let mut p1 = vec![9,2,6,3,1].into_iter().collect::<VecDeque<usize>>();
        let mut p2 = vec![5,8,4,7,10].into_iter().collect::<VecDeque<usize>>();
        play_recursive_game(&mut p1, &mut p2, 1);
        //println!("{:?}", p2);
        assert_eq!(calculate_score(&p1), 0);
        assert_eq!(calculate_score(&p2), 291);
    }

    #[test]
    fn part2() {
        let mut p1 = vec![29,21,38,30,25,7,2,36,16,44,20,12,45,4,31,34,33,42,50,14,39,37,11,43,18].into_iter().collect::<VecDeque<usize>>();
        let mut p2 = vec![32,24,10,41,13,3,6,5,9,8,48,49,46,17,22,35,1,19,23,28,40,26,47,15,27].into_iter().collect::<VecDeque<usize>>();
        play_recursive_game(&mut p1, &mut p2, 1);
        assert_eq!(calculate_score(&p1), 33661);
        //31612 too low
        //32677 too low
        assert_eq!(calculate_score(&p2), 0);
    }
}
