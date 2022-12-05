require_relative '../../2022/05/part1.rb'
require_relative '../../2022/05/part2.rb'

RSpec.describe "2022 Day 5" do
    part1 = Y2022::Day5::Part1
    part2 = Y2022::Day5::Part2

    context 'Part 1' do
        context "unit tests" do
            it 'can separate the input sections' do
                input = "    [D]
[N] [C]
[Z] [M] [P]
 1   2   3

move 1 from 2 to 1
move 3 from 1 to 3
move 2 from 2 to 1
move 1 from 1 to 2".lines.map(&:chomp)

                sections = part1.parse_sections(input)
                expect(sections).to eq [
                    [
                        "    [D]",
                        "[N] [C]",
                        "[Z] [M] [P]",
                        " 1   2   3"
                    ],
                    [
                        "move 1 from 2 to 1",
                        "move 3 from 1 to 3",
                        "move 2 from 2 to 1",
                        "move 1 from 1 to 2"
                    ]
                ]
            end

            it 'can parse the initial state' do
                input = "    [D]
[N] [C]
[Z] [M] [P]
 1   2   3".lines.map(&:chomp)

                stacks = part1.parse_stacks input
                expect(stacks).to eq({
                    1 => ['N', 'Z'],
                    2 => ['D', 'C', 'M'],
                    3 => ['P']
                })
            end

            it 'can parse the instructions' do
                input = "move 1 from 2 to 1
move 3 from 1 to 3
move 2 from 2 to 1
move 1 from 1 to 2
move 21 from 8 to 5".lines.map(&:chomp)

                instructions = part1.parse_instructions input
                expect(instructions).to eq [
                    {move: 1, from: 2, to: 1},
                    {move: 3, from: 1, to: 3},
                    {move: 2, from: 2, to: 1},
                    {move: 1, from: 1, to: 2},
                    {move: 21, from: 8, to: 5}
                ]
            end

            it 'can perform an instruction' do
                state = {
                    1 => ['N', 'Z'],
                    2 => ['D', 'C', 'M'],
                    3 => ['P']
                }

                instruction = {move: 1, from: 2, to: 1}
                part1.perform_instruction state, instruction
                expect(state).to eq ({
                    1 => ['D', 'N', 'Z'],
                    2 => ['C', 'M'],
                    3 => ['P']
                })

                instruction2 = {move: 3, from: 1, to: 3}
                part1.perform_instruction state, instruction2
                expect(state).to eq ({
                    1 => [],
                    2 => ['C', 'M'],
                    3 => ['Z', 'N', 'D', 'P']
                })
            end
        end

        context "examples" do
            it 'matches the numbers in the example' do
                input = "    [D]
[N] [C]
[Z] [M] [P]
 1   2   3

move 1 from 2 to 1
move 3 from 1 to 3
move 2 from 2 to 1
move 1 from 1 to 2".lines.map(&:chomp)

                result = part1.solve input
                expect(result).to eq 'CMZ'
            end
        end

        context "challenge" do
            it "finds the answer" do
                result = part1.solve
                expect(part1.solve).to eq 'RLFNRTNFB'
            end
        end
    end

    context 'Part 2' do
        context "examples" do
            it 'matches the numbers in the example' do
                input = "    [D]
[N] [C]
[Z] [M] [P]
 1   2   3

move 1 from 2 to 1
move 3 from 1 to 3
move 2 from 2 to 1
move 1 from 1 to 2".lines.map(&:chomp)

                result = part2.solve input
                expect(result).to eq "MCD"
            end
        end

        context "challenge" do
            it "finds the answer" do
                result = part2.solve
                expect(result).to eq "MHQTLJRLB"
            end
        end
    end
end
