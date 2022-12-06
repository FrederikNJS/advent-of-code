require_relative '../../2022/06/part1.rb'
require_relative '../../2022/06/part2.rb'

RSpec.describe "2022 Day 6" do
    part1 = Y2022::Day6::Part1
    part2 = Y2022::Day6::Part2

    context 'Part 1' do
        context "unit tests" do

        end

        context "examples" do
            it 'matches the numbers in the example' do
                example_inputs = [
                    ["mjqjpqmgbljsphdztnvjfqwrcgsmlb", 7],
                    ["bvwbjplbgvbhsrlpgdmjqwftvncz", 5],
                    ["nppdvjthqldpwncqszvftbrmjlhg", 6],
                    ["nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg", 10],
                    ["zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw", 11]
                ]
                example_inputs.each do |input, expected_output|
                    expect(part1.solve(input)).to eq expected_output
                end
            end
        end

        context "challenge" do
            it "finds the answer" do
                result = part1.solve
                expect(part1.solve).to eq 1262
            end
        end
    end

    context 'Part 2' do
        context "examples" do
            it 'matches the numbers in the example' do
                example_inputs = [
                    ["mjqjpqmgbljsphdztnvjfqwrcgsmlb", 19],
                    ["bvwbjplbgvbhsrlpgdmjqwftvncz", 23],
                    ["nppdvjthqldpwncqszvftbrmjlhg", 23],
                    ["nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg", 29],
                    ["zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw", 26]
                ]
                example_inputs.each do |input, expected_output|
                    expect(part2.solve(input)).to eq expected_output
                end
            end
        end

        context "challenge" do
            it "finds the answer" do
                result = part2.solve
                expect(result).to eq 3444
            end
        end
    end
end
