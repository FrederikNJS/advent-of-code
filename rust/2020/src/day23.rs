extern crate grok;

use std::collections::VecDeque;


fn take_next_three(cups: &mut VecDeque<usize>) -> Vec<usize> {
    cups.drain(1..=3).collect::<Vec<usize>>()
}

fn get_index(cups: &VecDeque<usize>, item_to_find: usize) -> usize {
    let mut index: Option<usize> = None;
    let mut item_to_find_2 = item_to_find;
    while index.is_none() {
        if item_to_find_2 < 1 {
            item_to_find_2 = *cups.into_iter().max().unwrap();
        }
        index = cups.into_iter().position(|item| *item == item_to_find_2);
        item_to_find_2 = item_to_find_2 - 1;
    }
    index.unwrap() + 1
}

#[allow(dead_code)]
fn perform_move(cups: &mut VecDeque<usize>) {
    let drained = take_next_three(cups);
    let destination = get_index(&cups, cups.front().unwrap() - 1);
    drained.into_iter().rev().for_each(|item| cups.insert(destination, item));
    cups.rotate_left(1);
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn example1() {
        let mut input: VecDeque<usize> = vec![3,8,9,1,2,5,4,6,7].into_iter().collect();
        for _ in 0..10 {
            //println!("{:?}", input);
            perform_move(&mut input);
        }
        let final_pos_1 = get_index(&input, 1);
        input.rotate_left(final_pos_1);
        input.pop_back();
        assert_eq!(input, vec![9,2,6,5,8,3,7,4]);
    }

    #[test]
    fn part1() {
        let mut input: VecDeque<usize> = vec![1,9,3,4,6,7,2,5,8].into_iter().collect();
        for _ in 0..100 {
            //println!("{:?}", input);
            perform_move(&mut input);
        }
        let final_pos_1 = get_index(&input, 1);
        input.rotate_left(final_pos_1);
        input.pop_back();
        assert_eq!(input, vec![2,5,4,6,8,3,7,9]);
    }

    #[test]
    fn example2() {

    }

    #[test]
    fn part2() {
        let mut input: VecDeque<usize> = vec![1,9,3,4,6,7,2,5,8].into_iter().collect();
        let extra_numbers = 10..=1_000_000;
        input.append(&mut extra_numbers.collect::<VecDeque<usize>>());
        for i in 0..10_000_000 {
            if i & 0b11111111111111 == 0 {
                println!("{}", i);
            }
            perform_move(&mut input);
        }
        let final_pos_1 = get_index(&input, 1);
        input.rotate_left(final_pos_1);
        let a = input.pop_front().unwrap();
        let b = input.pop_front().unwrap();
        println!("{} {} {}", a, b, a*b);
        assert_eq!(a, 723850);
        assert_eq!(b, 655865);
        assert_eq!(a*b, 474747880250);
        // too low   2030089135
        // too low  49274729391
        // target  474747880250
    }
}
