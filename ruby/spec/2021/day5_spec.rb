require 'pry'
require_relative '../../2021/05/part1.rb'
require_relative '../../2021/05/part2.rb'


RSpec.describe "2021 Day 05" do
    part1 = Y2021::Day5::Part1
    part2 = Y2021::Day5::Part2

    context 'Part 1' do

        context "unit tests" do
            it 'parses the coordinates' do
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

                expect(part1.parse_input raw_input).to eq [
                    {
                        from: {x: 0, y: 9},
                        to: {x: 5, y: 9}
                    },
                    {
                        from: {x: 8, y: 0},
                        to: {x: 0, y: 8}
                    },
                    {
                        from: {x: 9, y: 4},
                        to: {x: 3, y: 4},
                    },
                    {
                        from: {x: 2, y: 2},
                        to: {x: 2, y: 1},
                    },
                    {
                        from: {x: 7, y: 0},
                        to: {x: 7, y: 4},
                    },
                    {
                        from: {x: 6, y: 4},
                        to: {x: 2, y: 0},
                    },
                    {
                        from: {x: 0, y: 9},
                        to: {x: 2, y: 9},
                    },
                    {
                        from: {x: 3, y: 4},
                        to: {x: 1, y: 4},
                    },
                    {
                        from: {x: 0, y: 0},
                        to: {x: 8, y: 8},
                    },
                    {
                        from: {x: 5, y: 5},
                        to: {x: 8, y: 2},
                    }
                ]
            end

            it 'can filter the horizontal or vertical lines' do
                input = [
                    {
                        from: {x: 0, y: 9},
                        to: {x: 5, y: 9}
                    },
                    {
                        from: {x: 8, y: 0},
                        to: {x: 0, y: 8}
                    },
                    {
                        from: {x: 9, y: 4},
                        to: {x: 3, y: 4},
                    },
                    {
                        from: {x: 2, y: 2},
                        to: {x: 2, y: 1},
                    },
                    {
                        from: {x: 7, y: 0},
                        to: {x: 7, y: 4},
                    },
                    {
                        from: {x: 6, y: 4},
                        to: {x: 2, y: 0},
                    },
                    {
                        from: {x: 0, y: 9},
                        to: {x: 2, y: 9},
                    },
                    {
                        from: {x: 3, y: 4},
                        to: {x: 1, y: 4},
                    },
                    {
                        from: {x: 0, y: 0},
                        to: {x: 8, y: 8},
                    },
                    {
                        from: {x: 5, y: 5},
                        to: {x: 8, y: 2},
                    }
                ]

                expect(part1.filter_lines input).to eq [
                    {
                        from: {x: 0, y: 9},
                        to: {x: 5, y: 9}
                    },
                    {
                        from: {x: 9, y: 4},
                        to: {x: 3, y: 4},
                    },
                    {
                        from: {x: 2, y: 2},
                        to: {x: 2, y: 1},
                    },
                    {
                        from: {x: 7, y: 0},
                        to: {x: 7, y: 4},
                    },
                    {
                        from: {x: 0, y: 9},
                        to: {x: 2, y: 9},
                    },
                    {
                        from: {x: 3, y: 4},
                        to: {x: 1, y: 4},
                    }
                ]
            end
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
                lines_left = part1.filter_lines lines
                sea_floor = part1.make_sea_floor lines_left
                expect(part1.count_overlaps sea_floor).to eq 5
            end
        end

        context "challenge" do
            it "finds the answer" do
                raw_input = part1.read_input
                lines = part1.parse_input raw_input
                lines_left = part1.filter_lines lines
                sea_floor = part1.make_sea_floor lines_left
                expect(part1.count_overlaps sea_floor).to eq 4993
            end
        end
    end

    context 'Part 2' do
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
end
