require_relative '../../2021/09/part1.rb'
require_relative '../../2021/09/part2.rb'
require 'pry'

RSpec.describe '2021 Day 09' do
    part1 = Y2021::Day9::Part1
    part2 = Y2021::Day9::Part2

    context 'Part 1' do
        context 'unit tests' do

        end

        context 'examples' do
            it 'matches the numbers in the first example' do
                raw_example = "2199943210
3987894921
9856789892
8767896789
9899965678".lines.map(&:chomp)
                input = part1.parse_input raw_example
                low_points = part1.find_low_points input
                expect(low_points).to eq({
                    [0,1] => 1,
                    [0,9] => 0,
                    [2,2] => 5,
                    [4,6] => 5
                })
                risk_level = part1.calculate_risk_level low_points
                expect(risk_level).to eq 15
            end
        end

        context "challenge" do
            it "finds the answer" do
                raw = part1.read_input
                input = part1.parse_input raw
                low_points = part1.find_low_points input
                risk_level = part1.calculate_risk_level low_points
                expect(risk_level).to eq 560
            end
        end
    end

    context 'Part 2' do
        context 'unit tests' do
            it 'can build a closest minimum map' do

            end
        end

        context "examples" do
            it 'matches the numbers in the example' do
                raw_example = "2199943210
3987894921
9856789892
8767896789
9899965678".lines.map(&:chomp)
                input = part1.parse_input raw_example
                low_points = part1.find_low_points input
                basins = part2.create_basins input, low_points
                largest_basings = part2.biggest_3_basins basins
                expect(largest_basings[0] * largest_basings[1] * largest_basings[2]).to eq 1134
            end
        end

        context "challenge" do
            it "finds the answer" do
                raw_example = part1.read_input
                input = part1.parse_input raw_example
                low_points = part1.find_low_points input
                basins = part2.create_basins input, low_points
                largest_basings = part2.biggest_3_basins basins
                expect(largest_basings[0] * largest_basings[1] * largest_basings[2]).to eq 959136
            end
        end
    end
end
