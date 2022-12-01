require_relative '../../2022/01/part1.rb'
require_relative '../../2022/01/part2.rb'

RSpec.describe "2022 Day 1" do
    part1 = Y2022::Day1::Part1
    part2 = Y2022::Day1::Part2

    context 'Part 1' do
        context "unit tests" do
            it 'can read the input' do
                input = part1.read_input
                expect(input[0]).to eq 11334
                expect(input[1]).to eq 6264
                expect(input[2]).to eq 9318
                expect(input[3]).to be 0
            end

            it 'can split elves' do
                example_values = [
                    1000,
                    2000,
                    3000,
                    0,
                    4000,
                    0,
                    5000,
                    6000,
                    0,
                    7000,
                    8000,
                    9000,
                    0,
                    10000
                ]
                chunks = part1.split_elves(example_values)
                expect(chunks).to eq [
                    [1000, 2000, 3000, 0],
                    [4000, 0],
                    [5000, 6000, 0],
                    [7000, 8000, 9000, 0],
                    [10000]
                ]
            end
        end

        context "examples" do
            it 'matches the numbers in the example' do
                example_values = [
                    1000,
                    2000,
                    3000,
                    0,
                    4000,
                    0,
                    5000,
                    6000,
                    0,
                    7000,
                    8000,
                    9000,
                    0,
                    10000
                ]
                chunks = part1.split_elves(example_values)
                sums = part1.sum_elves(chunks)
                expect(sums).to eq [6000, 4000, 11000, 24000, 10000]
            end
        end

        context "challenge" do
            it "finds the answer" do
                input = part1.read_input
                chunks = part1.split_elves input
                sums = part1.sum_elves chunks
                expect(sums.max).to eq 66186
            end
        end
    end

    context 'Part 2' do
        context "examples" do
            it 'matches the numbers in the example' do

            end
        end

        context "challenge" do
            it "finds the answer" do
                input = part1.read_input
                chunks = part1.split_elves input
                sums = part1.sum_elves chunks
                sorted = sums.sort.reverse
                expect(sorted[0..2]).to eq [66186, 65638, 64980]
                expect(sorted[0..2].sum).to eq 196804
            end
        end
    end
end
