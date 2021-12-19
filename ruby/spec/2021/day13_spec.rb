require 'immutable'
require_relative '../../2021/13/part1.rb'
require_relative '../../2021/13/part2.rb'
require 'pry'

RSpec.describe '2021 Day 13' do
    part1 = Y2021::Day13::Part1
    part2 = Y2021::Day13::Part2

    context 'Part 1' do
        context 'unit tests' do
        end

        context 'examples' do
            it 'matches the numbers in the first example' do
                raw = "6,10
0,14
9,10
0,3
10,4
4,11
6,0
6,12
4,1
0,13
10,12
3,4
3,0
8,4
1,10
2,14
8,10
9,0

fold along y=7
fold along x=5"
                coordinates, instructions = part1.parse_input raw
                folded = part1.fold_once coordinates, instructions[0]
                expect(folded.size).to eq 17
            end
        end

        context "challenge" do
            it "finds the answer" do
                raw = part1.read_input
                coordinates, instructions = part1.parse_input raw
                folded = part1.fold_once coordinates, instructions[0]
                expect(folded.size).to eq 753
            end
        end
    end

    context 'Part 2' do
        context 'unit tests' do

        end

        context "examples" do
            it 'matches the numbers in the example' do
                raw = "6,10
0,14
9,10
0,3
10,4
4,11
6,0
6,12
4,1
0,13
10,12
3,4
3,0
8,4
1,10
2,14
8,10
9,0

fold along y=7
fold along x=5"
                coordinates, instructions = part1.parse_input raw
                folded = part1.fold_all coordinates, instructions
                expect(folded).to eq (Set[
                    [0,0],
                    [0,1],
                    [0,2],
                    [0,3],
                    [0,4],
                    [1,0],
                    [1,4],
                    [2,0],
                    [2,4],
                    [3,0],
                    [3,4],
                    [4,0],
                    [4,1],
                    [4,2],
                    [4,3],
                    [4,4]
                ])
            end
        end

        context "challenge" do
            it "finds the answer" do
                raw = part1.read_input
                coordinates, instructions = part1.parse_input raw
                folded = part1.fold_all coordinates, instructions
                part1.print(folded)
            end
        end
    end
end
