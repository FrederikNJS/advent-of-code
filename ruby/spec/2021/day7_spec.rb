require_relative '../../2021/07/part1.rb'
require_relative '../../2021/07/part2.rb'
require 'pry'

RSpec.describe "2021 Day 07" do
    part1 = Y2021::Day7::Part1
    part2 = Y2021::Day7::Part2

    context 'Part 1' do
        context "unit tests" do
            it 'parse the input' do
                raw = "16,1,2,0,4,2,7,1,2,14"
                expect(part1.parse_input raw).to eq [16,1,2,0,4,2,7,1,2,14]
            end

            it 'can calculate the fuel cost' do
                crab_positions = [16,1,2,0,4,2,7,1,2,14]

                expect(part1.calculate_fuel_cost crab_positions, 2).to eq [14,1,0,2,2,0,5,1,0,12]
                expect(part1.calculate_fuel_cost(crab_positions, 2).sum).to eq 37

                expect(part1.calculate_fuel_cost(crab_positions, 1).sum).to eq 41
                expect(part1.calculate_fuel_cost(crab_positions, 3).sum).to eq 39
                expect(part1.calculate_fuel_cost(crab_positions, 10).sum).to eq 71
            end

            it 'can calculate the best position' do
                crab_positions = [16,1,2,0,4,2,7,1,2,14]
                expect(part1.find_best_position crab_positions).to eq [2, 37]
            end
        end

        context "examples" do
            it 'matches the numbers in the first example' do
                crab_positions = [16,1,2,0,4,2,7,1,2,14]
                expect(part1.find_best_position crab_positions).to eq [2, 37]
            end
        end

        context "challenge" do
            it "finds the answer" do
                raw = part1.read_input
                crab_positions = part1.parse_input raw
                position, fuel_cost = part1.find_best_position crab_positions
                expect(fuel_cost).to be > 262
                expect(fuel_cost).to eq 359648
                expect(position).to eq 346
            end
        end
    end

    context 'Part 2' do
        context 'unit tests' do
            it 'can calculate the fuel cost' do
                crab_positions = [16,1,2,0,4,2,7,1,2,14]

                expect(part2.calculate_fuel_cost crab_positions, 5).to eq [66,10,6,15,1,6,3,10,6,45]
                expect(part2.calculate_fuel_cost(crab_positions, 5).sum).to eq 168

                expect(part2.calculate_fuel_cost(crab_positions, 2).sum).to eq 206
            end

            it 'can calculate the best position' do
                crab_positions = [16,1,2,0,4,2,7,1,2,14]
                expect(part2.find_best_position crab_positions).to eq [5, 168]
            end
        end

        context "examples" do
            it 'matches the numbers in the example' do

            end
        end

        context "challenge" do
            it "finds the answer" do
                raw = part1.read_input
                crab_positions = part1.parse_input raw
                position, fuel_cost = part2.find_best_position crab_positions
                expect(fuel_cost).to eq 100727924
                expect(position).to eq 497
            end
        end
    end
end
