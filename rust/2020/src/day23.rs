extern crate grok;

use std::collections::VecDeque;
use itertools::Itertools;


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

#[allow(dead_code)]
fn perform_move_2(next_map: &mut Vec<usize>, current: usize) -> usize {
    let n1 = next_map[current];
    let n2 = next_map[n1];
    let n3 = next_map[n2];
    let n4 = next_map[n3];

    //println!("{} {} {} {} {} {}", current, n1, n2, n3, n4, next_map.len());

    // cut next three out
    next_map[current] = n4;

    // get destination
    let mut destination = if current == 1 {next_map.len() - 1} else {current - 1};
    while destination < 1 || destination == n1 || destination == n2 || destination == n3 {
        //println!("{}", destination);
        if destination == 0 {
            destination = next_map.len() - 1;
        } else {
            destination = destination - 1;
        }
    }
    //println!("{}", destination);

    next_map[n3] = next_map[destination];
    next_map[destination] = n1;

    n4
}

#[allow(dead_code)]
fn build_next_map(iv: &Vec<usize>, max_cup: usize) -> Vec<usize> {
    let mut input: Vec<usize> = (1..=(max_cup+1)).collect();
    for n in 1..iv.len() {
        let a = iv[n-1];
        let b = iv[n];
        input[a] = b;
    }

    if max_cup > iv.len() {
        input[max_cup] = iv[0];
    } else {
        input[iv[iv.len()-1]] = iv[0];
    }
    input
}

#[allow(dead_code)]
fn rebuild_array(next_map: &Vec<usize>, current: usize, items_to_rebuild: usize) -> Vec<usize> {
    let mut item = current;
    let mut rebuilt = vec![current];
    for _ in 0..items_to_rebuild {
        item = next_map[item];
        rebuilt.push(item);
    }
    rebuilt
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

    #[ignore]
    #[test]
    fn test_perform_move_2_debug() {
        let max_cup = 9;
        let iv: Vec<usize> = vec![2,8,9,1,5,4,6,7,3];
        let mut input = build_next_map(&iv, max_cup);
        let mut current = iv[0];
        assert_eq!(rebuild_array(&input, current, 9), vec![2,8,9,1,5,4,6,7,3,2]);
        current = perform_move_2(&mut input, current);
        assert_eq!(rebuild_array(&input, current, 9), vec![5,4,6,7,8,9,1,3,2,5]);
    }


    #[test]
    fn test_perform_move_2() {
        let max_cup = 9;
        let iv: Vec<usize> = vec![3,8,9,1,2,5,4,6,7];
        let mut input = build_next_map(&iv, max_cup);
        let mut current = iv[0];

        assert_eq!(rebuild_array(&input, current, 9), vec![3,8,9,1,2,5,4,6,7,3]);
        current = perform_move_2(&mut input, current);
        assert_eq!(rebuild_array(&input, current, 9), vec![2,8,9,1,5,4,6,7,3,2]);
        current = perform_move_2(&mut input, current);
        assert_eq!(rebuild_array(&input, current, 9), vec![5,4,6,7,8,9,1,3,2,5]);
        current = perform_move_2(&mut input, current);
        assert_eq!(rebuild_array(&input, current, 9), vec![8,9,1,3,4,6,7,2,5,8]);
        current = perform_move_2(&mut input, current);
        assert_eq!(rebuild_array(&input, current, 9), vec![4,6,7,9,1,3,2,5,8,4]);
        current = perform_move_2(&mut input, current);
        assert_eq!(rebuild_array(&input, current, 9), vec![1,3,6,7,9,2,5,8,4,1]);
        current = perform_move_2(&mut input, current);
        assert_eq!(rebuild_array(&input, current, 9), vec![9,3,6,7,2,5,8,4,1,9]);
        current = perform_move_2(&mut input, current);
        assert_eq!(rebuild_array(&input, current, 9), vec![2,5,8,3,6,7,4,1,9,2]);
        current = perform_move_2(&mut input, current);
        assert_eq!(rebuild_array(&input, current, 9), vec![6,7,4,1,5,8,3,9,2,6]);
        current = perform_move_2(&mut input, current);
        assert_eq!(rebuild_array(&input, current, 9), vec![5,7,4,1,8,3,9,2,6,5]);
        current = perform_move_2(&mut input, current);
        assert_eq!(rebuild_array(&input, current, 9), vec![8,3,7,4,1,9,2,6,5,8]);
    }

    #[test]
    fn example1_2() {
        let max_cup = 9;
        let iv: Vec<usize> = vec![3,8,9,1,2,5,4,6,7];
        let mut input = build_next_map(&iv, max_cup);
        let mut current = iv[0];

        for _ in 0..10 {
            current = perform_move_2(&mut input, current);
        }

        assert_eq!(rebuild_array(&input, current, 9), vec![9,3,6,7,2,5,8,4,1,9]);
        assert_eq!(input[9], 3);
        assert_eq!(input[3], 6);
        assert_eq!(input[6], 7);
        assert_eq!(input[7], 2);
        assert_eq!(input[2], 5);
        assert_eq!(input[5], 8);
        assert_eq!(input[8], 4);
        assert_eq!(input[4], 1);
        assert_eq!(input[1], 9);
    }

    #[test]
    fn example1_3() {
        let max_cup = 20;
        let iv: Vec<usize> = vec![3,8,9,1,2,5,4,6,7];
        let mut input = build_next_map(&iv, max_cup);
        let mut current = iv[0];

        for _ in 0..10 {
            current = perform_move_2(&mut input, current);
        }

        assert_eq!(rebuild_array(&input, current, 9), vec![9,3,6,7,2,5,8,4,1,9]);
    }

    #[test]
    fn part2() {
        let max_cup = 1_000_000;
        let iv = vec![1,9,3,4,6,7,2,5,8];
        let mut input = build_next_map(&iv, max_cup);
        let mut current = iv[0];

        for _ in 0..10_000_000 {
            current = perform_move_2(&mut input, current);
        }

        let result = rebuild_array(&input, 1, 9);
        println!("{:?}", result);
        let a = input[1];
        let b = input[input[1]];
        println!("{:?}", input.get(0..20));
        assert_eq!(a, 934001);
        assert_eq!(b, 159792);
        assert_eq!(a*b, 149245887792);
    }

    #[ignore]
    #[test]
    fn part2_slow() {
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

        // 723850 655865 474747880250
        // test day23::tests::part2 ... ok <5931.270s>
    }
}
