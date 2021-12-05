require 'pry'
require_relative '../../../2021/05/part1.rb'
require_relative '../../../2021/05/part2.rb'

RSpec.describe "2021/05/Part1" do
    part1 = Y2021::Day5::Part1
    part2 = Y2021::Day5::Part2

    context "unit tests" do
    end

    context "examples" do
        it 'matches the numbers in the example' do
            raw_input = "0,9 -> 5,9
8,0 -> 0,8
9,4 -> 3,4
2,2 -> 2,1
7,0 -> 7,4
6,4 -> 2,0
0,9 -> 2,9
3,4 -> 1,4
0,0 -> 8,8
5,5 -> 8,2".split("\n")
            lines = part1.parse_input raw_input
            sea_floor = part2.make_sea_floor lines
            expect(part1.count_overlaps sea_floor).to eq 12
        end
    end

    context "challenge" do
        it "finds the answer" do
            raw_input = part1.read_input
            lines = part1.parse_input raw_input
            sea_floor = part2.make_sea_floor lines
            expect(part1.count_overlaps sea_floor).to eq 21101
        end
    end
end
