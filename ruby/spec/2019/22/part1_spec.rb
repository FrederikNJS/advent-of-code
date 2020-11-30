require_relative '../../../2019/22/part1.rb'
require 'pry'

RSpec.describe '2019/22/Part1' do
    it 'deal into new stack' do
        deck = (0..9).to_a
        res = Day201922Part1::deal_into_new_deck(deck)
        expect(res).to eq [9, 8, 7, 6, 5, 4, 3, 2, 1, 0]
    end

    it 'cut n' do
        deck = (0..9).to_a
        res = Day201922Part1::cut(deck, 3)
        expect(res).to eq [3, 4, 5, 6, 7, 8, 9, 0, 1, 2]
    end

    it 'cut n negative' do
        deck = (0..9).to_a
        res = Day201922Part1::cut(deck, -4)
        expect(res).to eq [6, 7, 8, 9, 0, 1, 2, 3, 4, 5]
    end

    it 'deal with increment' do
        deck = (0..9).to_a
        res = Day201922Part1::deal_with_increment(deck, 3)
        expect(res).to eq [0, 7, 4, 1, 8, 5, 2, 9, 6, 3]
    end

    it 'works with example 1' do
        deck = (0..9).to_a
        instructions = [
            "deal with increment 7",
            "deal into new stack",
            "deal into new stack",
        ]
        res = Day201922Part1::shuffle(deck, instructions)
        expect(res).to eq [0, 3, 6, 9, 2, 5, 8, 1, 4, 7]
    end

    it 'works with example 2' do
        deck = (0..9).to_a
        instructions = [
            "cut 6",
            "deal with increment 7",
            "deal into new stack",
        ]
        res = Day201922Part1::shuffle(deck, instructions)
        expect(res).to eq [3, 0, 7, 4, 1, 8, 5, 2, 9, 6]
    end

    it 'works with example 3' do
        deck = (0..9).to_a
        instructions = [
            "deal with increment 7",
            "deal with increment 9",
            "cut -2",
        ]
        res = Day201922Part1::shuffle(deck, instructions)
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
        res = Day201922Part1::shuffle(deck, instructions)
        expect(res).to eq [9, 2, 5, 8, 1, 4, 7, 0, 3, 6]
    end

end
