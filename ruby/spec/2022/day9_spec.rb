require_relative '../../2022/09/part1.rb'
require_relative '../../2022/09/part2.rb'

RSpec.describe "2022 Day 09" do
    part1 = Y2022::Day09::Part1
    part2 = Y2022::Day09::Part2

    context 'Part 1' do
        context "unit tests" do
            it 'parses the instructions' do
                input = 'R 4
U 4
L 3
D 1
R 4
D 1
L 5
R 2'.lines.map(&:chomp)

                parsed = part1.parse_instructions input
                expect(parsed).to eq ([
                    ['R', 4],
                    ['U', 4],
                    ['L', 3],
                    ['D', 1],
                    ['R', 4],
                    ['D', 1],
                    ['L', 5],
                    ['R', 2]
                ])
            end

            it 'performs instructions' do
                snake = [
                    {x: 0, y: 0},
                    {x: 0, y: 0}
                ]
                instructions = [
                    ['R', 4],
                    ['U', 4],
                    ['L', 3],
                    ['D', 1],
                    ['R', 4],
                    ['D', 1],
                    ['L', 5],
                    ['R', 2]
                ]

                part1.perform_move snake, *instructions[0]
                expect(snake).to eq ([
                    {x: 4, y: 0},
                    {x: 3, y: 0}
                ])
                part1.perform_move snake, *instructions[1]
                expect(snake).to eq ([
                    {x: 4, y: 4},
                    {x: 4, y: 3}
                ])
                part1.perform_move snake, *instructions[2]
                expect(snake).to eq ([
                    {x: 1, y: 4},
                    {x: 2, y: 4}
                ])
                part1.perform_move snake, *instructions[3]
                expect(snake).to eq ([
                    {x: 1, y: 3},
                    {x: 2, y: 4}
                ])
            end
        end

        context "examples" do
            it 'matches the numbers in the example' do
                input = 'R 4
U 4
L 3
D 1
R 4
D 1
L 5
R 2'.lines.map(&:chomp)

                result = part1.solve input
                expect(result).to eq 13
            end
        end

        context "challenge" do
            it "finds the answer" do
                result = part1.solve
                expect(part1.solve).to eq 6256
            end
        end
    end

    context 'Part 2' do
        context "examples" do
            it 'matches the numbers in the example' do
                input = input = 'R 4
U 4
L 3
D 1
R 4
D 1
L 5
R 2'.lines.map(&:chomp)

                result = part2.solve input
                expect(result).to eq 1
            end

            it 'matches the numbers in the larger example' do
                input = input = 'R 5
U 8
L 8
D 3
R 17
D 10
L 25
U 20'.lines.map(&:chomp)

                result = part2.solve input
                expect(result).to eq 36
            end
        end

        context "challenge" do
            it "finds the answer" do
                result = part2.solve
                expect(result).to be > 205
                expect(result).to eq 2665
            end
        end
    end
end
