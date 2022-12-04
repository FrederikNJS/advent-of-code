require_relative '../../2022/04/part1.rb'
require_relative '../../2022/04/part2.rb'

RSpec.describe "2022 Day 4" do
    part1 = Y2022::Day4::Part1
    part2 = Y2022::Day4::Part2

    context 'Part 1' do
        context "unit tests" do
            it 'can parse a line' do
                line = '2-4,6-8'
                parsed = part1.parse_line line
                expect(parsed).to eq [
                    Range.new(2,4),
                    Range.new(6,8)
                ]
            end
        end

        context "examples" do
            it 'matches the numbers in the example' do
                input = "2-4,6-8
2-3,4-5
5-7,7-9
2-8,3-7
6-6,4-6
2-6,4-8".lines
                result = part1.solve input
                expect(result).to eq 2
            end
        end

        context "challenge" do
            it "finds the answer" do
                result = part2.solve
                expect(part1.solve).to eq 500
            end
        end
    end

    context 'Part 2' do
        context "examples" do
            it 'matches the numbers in the example' do
                input = "2-4,6-8
2-3,4-5
5-7,7-9
2-8,3-7
6-6,4-6
2-6,4-8".lines
                result = part2.solve input
                expect(result).to eq 4
            end
        end

        context "challenge" do
            it "finds the answer" do
                result = part2.solve
                expect(result).to eq 815
            end
        end
    end
end
