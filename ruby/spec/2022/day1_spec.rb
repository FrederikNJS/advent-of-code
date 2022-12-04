require_relative '../../2022/01/part1.rb'
require_relative '../../2022/01/part2.rb'

RSpec.describe "2022 Day 1" do
    part1 = Y2022::Day1::Part1
    part2 = Y2022::Day1::Part2

    context 'Part 1' do
        context "unit tests" do
            it 'can parse the input' do
                input = '1000
2000
3000

4000'.lines
                parsed = part1.parse_input input
                expect(parsed[0]).to eq 1000
                expect(parsed[1]).to eq 2000
                expect(parsed[2]).to eq 3000
                expect(parsed[3]).to be 0
                expect(parsed[4]).to be 4000
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
                input = '1000
2000
3000

4000

5000
6000

7000
8000
9000

10000'.lines

                result = part1.solve input
                expect(result).to eq 24000
            end
        end

        context "challenge" do
            it "finds the answer" do
                result = part1.solve
                expect(result).to eq 66186
            end
        end
    end

    context 'Part 2' do
        context "examples" do
            it 'matches the numbers in the example' do
                input = '1000
2000
3000

4000

5000
6000

7000
8000
9000

10000'.lines

                result = part2.solve input
                expect(result).to eq 45000
            end
        end

        context "challenge" do
            it "finds the answer" do
                result = part2.solve
                expect(result).to eq 196804
            end
        end
    end
end
