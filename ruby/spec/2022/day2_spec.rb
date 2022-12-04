require_relative '../../2022/02/part1.rb'
require_relative '../../2022/02/part2.rb'

RSpec.describe "2022 Day 2" do
    part1 = Y2022::Day2::Part1
    part2 = Y2022::Day2::Part2

    context 'Part 1' do
        context "unit tests" do
            it 'can read the input' do

            end

            it 'score a match' do
                result = part1.calculate_game_score :rock, :scissors
                expect(result).to eq 3

                result = part1.calculate_game_score :scissors, :rock
                expect(result).to eq 7
            end
        end

        context "examples" do
            it 'matches the numbers in the example' do
                input = [
                    'A Y',
                    'B X',
                    'C Z'
                ]

                parsed = part1.parse_input input
                result = part1.calculate_guide parsed
                expect(result).to eq 15
            end
        end

        context "challenge" do
            it "finds the answer" do
                input = part1.read_input
                guide = part1.parse_input input
                result = part1.calculate_guide guide
                expect(result).to eq 13809
            end
        end
    end

    context 'Part 2' do
        context "examples" do
            it 'matches the numbers in the example' do
                input = [
                    'A Y',
                    'B X',
                    'C Z'
                ]

                parsed = part2.parse_input input
                result = part2.calculate_guide parsed
                expect(result).to eq 12
            end
        end

        context "challenge" do
            it "finds the answer" do
                input = part1.read_input
                guide = part2.parse_input input
                result = part2.calculate_guide guide
                expect(result).to eq 12316
            end
        end
    end
end
