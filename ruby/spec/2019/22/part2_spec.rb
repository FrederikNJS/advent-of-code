require_relative '../../../2019/22/part1.rb'
require_relative '../../../2019/22/part2.rb'
require 'pry'

RSpec.describe '2019/22/Part2' do
    part1 = Day201922Part1
    part2 = Day201922Part2
    it 'deal into new stack' do
        index = 2
        max = 9
        new_index = part2::deal_into_new_deck(max, index)
        expect(new_index).to eq 7
        #[9, 8, 7, 6, 5, 4, 3, 2, 1, 0]
    end

    it 'cut n' do
        index = 2
        max = 9
        new_index = part2::cut(max, index, 3)
        expect(new_index).to eq 5
        #[3, 4, 5, 6, 7, 8, 9, 0, 1, 2]
    end

    it 'cut n negative' do
        index = 2
        max = 9
        new_index = part2::cut(max, index, -4)
        expect(new_index).to eq 8
        #[6, 7, 8, 9, 0, 1, 2, 3, 4, 5]
    end

    xit 'deal with increment' do
        index = 2
        max = 9
        new_index = part1::deal_with_increment(max, index, 3)
        expect(new_index).to eq 4
        #[0, 7, 4, 1, 8, 5, 2, 9, 6, 3]
    end

    it 'works with example 1' do
        deck = (0..9).to_a
        instructions = [
            "deal with increment 7",
            "deal into new stack",
            "deal into new stack",
        ]
        res = part1::shuffle(deck, instructions)
        expect(res).to eq [0, 3, 6, 9, 2, 5, 8, 1, 4, 7]
    end

    it 'works with example 2' do
        deck = (0..9).to_a
        instructions = [
            "cut 6",
            "deal with increment 7",
            "deal into new stack",
        ]
        res = part1::shuffle(deck, instructions)
        expect(res).to eq [3, 0, 7, 4, 1, 8, 5, 2, 9, 6]
    end

    it 'works with example 3' do
        deck = (0..9).to_a
        instructions = [
            "deal with increment 7",
            "deal with increment 9",
            "cut -2",
        ]
        res = part1::shuffle(deck, instructions)
        expect(res).to eq [6, 3, 0, 7, 4, 1, 8, 5, 2, 9]
    end

    it 'works with example 4' do
        deck = (0..9).to_a
        instructions = [
            "deal into new stack",
            "cut -2",
            "deal with increment 7",
            "cut 8",
            "cut -4",
            "deal with increment 7",
            "cut 3",
            "deal with increment 9",
            "deal with increment 3",
            "cut -1",
        ]
        res = part1::shuffle(deck, instructions)
        expect(res).to eq [9, 2, 5, 8, 1, 4, 7, 0, 3, 6]
    end

end
