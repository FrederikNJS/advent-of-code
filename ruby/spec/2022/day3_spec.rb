require_relative '../../2022/03/part1.rb'
require_relative '../../2022/03/part2.rb'

RSpec.describe "2022 Day 3" do
    part1 = Y2022::Day3::Part1
    part2 = Y2022::Day3::Part2

    context 'Part 1' do
        context "unit tests" do
            it 'can read the input' do

            end

            it 'can parse rucksacks' do
                rucksack = 'vJrwpWtwJgWrhcsFMMfFFhFp'
                parsed = part1.parse_rucksack(rucksack)
                expect(parsed).to eq [
                    Set["v", "J", "r", "w", "p", "W", "t", "g"],
                    Set["h", "c", "s", "F", "M", "f", "p"]
                ]
            end

            it 'can find the common items' do
                rucksacks = [
                    Set["v", "J", "r", "w", "p", "W", "t", "g"],
                    Set["h", "c", "s", "F", "M", "f", "p"]
                ]
                result = part1.find_commonalities rucksacks
                expect(result).to eq Set['p']
            end

            it 'can find the priority of a commonality' do
                input = Set['p']
                priority = part1.calculate_priority input
                expect(priority).to eq 16
            end
        end

        context "examples" do
            it 'matches the numbers in the example' do
                input = "vJrwpWtwJgWrhcsFMMfFFhFp
jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
PmmdzqPrVvPwwTWBwg
wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
ttgJtRGJQctTZtZT
CrZsJsPPZsGzwwsLwLmpwMDw".lines
                result = part1.solve input
                expect(result).to eq 157
            end
        end

        context "challenge" do
            it "finds the answer" do
                expect(part1.solve).to eq 7793
            end
        end
    end

    context 'Part 2' do
        context "examples" do
            it 'matches the numbers in the example' do
                input = "vJrwpWtwJgWrhcsFMMfFFhFp
jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
PmmdzqPrVvPwwTWBwg
wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
ttgJtRGJQctTZtZT
CrZsJsPPZsGzwwsLwLmpwMDw".lines
                                result = part2.solve input
                                expect(result).to eq 70
            end
        end

        context "challenge" do
            it "finds the answer" do
                result = part2.solve
                expect(result).to eq 2499
            end
        end
    end
end
