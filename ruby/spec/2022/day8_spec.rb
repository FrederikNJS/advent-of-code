require_relative '../../2022/08/part1.rb'
require_relative '../../2022/08/part2.rb'

RSpec.describe "2022 Day 8" do
    part1 = Y2022::Day8::Part1
    part2 = Y2022::Day8::Part2

    context 'Part 1' do
        context "unit tests" do
            where(:x, :y, :visible) do
                [
                    [1, 1, true],
                    [2, 1, true],
                    [3, 1, false],
                    [1, 2, true],
                    [2, 2, false],
                    [3, 2, true],
                    [1, 3, false],
                    [2, 3, true],
                    [3, 3, false]
                ]
            end

            with_them do
                it 'can test whether a tree is visible' do
                    input = "30373
25512
65332
33549
35390".lines.map(&:chomp)
                    grid = part1.parse_grid input
                    expect(part1.tree_is_visible?(grid, x, y)).to be visible
                end
            end
        end

        context "examples" do
            it 'matches the numbers in the example' do
                input = "30373
25512
65332
33549
35390".lines.map(&:chomp)

                result = part1.solve input
                expect(result).to eq 21
            end
        end

        context "challenge" do
            it "finds the answer" do
                result = part1.solve
                expect(part1.solve).to eq 1835
            end
        end
    end

    context 'Part 2' do
        context "unit tests" do
            where(:x, :y, :expected_scenic_score) do
                [
                    [2, 1, 4],
                    [2, 3, 8],
                ]
            end

            with_them do
                it 'matches the numbers in the example' do
                    input = "30373
25512
65332
33549
35390".lines.map(&:chomp)
                    grid = part1.parse_grid input
                    scenic_score = part2.calculate_scenic_score grid, x, y
                    expect(scenic_score).to eq expected_scenic_score
                end
            end
        end

        context "examples" do
            it 'matches the numbers in the example' do
                input = "30373
25512
65332
33549
35390".lines.map(&:chomp)

                result = part2.solve input
                expect(result).to eq 8
            end
        end

        context "challenge" do
            it "finds the answer" do
                result = part2.solve
                expect(result).to eq 263670
            end
        end
    end
end
