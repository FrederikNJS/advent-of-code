require_relative '../../2021/11/part1.rb'
require_relative '../../2021/11/part2.rb'
require 'pry'

RSpec.describe '2021 Day 11' do
    part1 = Y2021::Day11::Part1
    part2 = Y2021::Day11::Part2

    context 'Part 1' do
        context 'unit tests' do

        end

        context 'examples' do
            it 'matches the numbers in the first' do
                input = part1.grid_to_map([
                    [1,1,1,1,1],
                    [1,9,9,9,1],
                    [1,9,1,9,1],
                    [1,9,9,9,1],
                    [1,1,1,1,1]
                ])
                after_1_step, flash_count = part1.step(input)
                expect(after_1_step).to eq part1.grid_to_map([
                    [3,4,5,4,3],
                    [4,0,0,0,4],
                    [5,0,0,0,5],
                    [4,0,0,0,4],
                    [3,4,5,4,3]
                ])
                expect(flash_count).to eq 9

                after_2_steps, flash_count = part1.step(after_1_step)
                expect(after_2_steps).to eq part1.grid_to_map([
                    [4,5,6,5,4],
                    [5,1,1,1,5],
                    [6,1,1,1,6],
                    [5,1,1,1,5],
                    [4,5,6,5,4]
                ])
                expect(flash_count).to eq 0
            end

            it 'matches the numbers in the second example' do
                raw_example = "5483143223
2745854711
5264556173
6141336146
6357385478
4167524645
2176841721
6882881134
4846848554
5283751526".lines.map(&:chomp)
                input = part1.parse_input raw_example
                flash_count = 0
                100.times do
                    input, flashes = part1.step input
                    flash_count += flashes
                end
                expect(flash_count).to eq 1656
            end
        end

        context "challenge" do
            it "finds the answer" do
                raw = part1.read_input
                input = part1.parse_input raw
                flash_count = 0
                100.times do
                    input, flashes = part1.step input
                    flash_count += flashes
                end
                expect(flash_count).to be < 102520
                expect(flash_count).to eq 1691
            end
        end
    end

    context 'Part 2' do
        context 'unit tests' do

        end

        context "examples" do
            it 'matches the numbers in the example' do
                raw_example = "5483143223
2745854711
5264556173
6141336146
6357385478
4167524645
2176841721
6882881134
4846848554
5283751526".lines.map(&:chomp)
                input = part1.parse_input raw_example
                winning_round = -1
                200.times do |round|
                    input, flashes = part1.step input
                    if flashes == input.size
                        winning_round = round + 1
                        break
                    end
                end
                expect(winning_round).to eq 195
            end
        end

        context "challenge" do
            it "finds the answer" do
                raw = part1.read_input

                input = part1.parse_input raw
                winning_round = -1
                1000.times do |round|
                    input, flashes = part1.step input
                    if flashes == input.size
                        winning_round = round + 1
                        break
                    end
                end
                expect(winning_round).to be > 215
                expect(winning_round).to eq 216
            end
        end
    end
end
