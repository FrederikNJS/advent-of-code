require 'immutable'
require_relative '../../2021/18/part1.rb'
require_relative '../../2021/18/part2.rb'
require 'pry'

RSpec.xdescribe '2021 Day 18' do
    part1 = Y2021::Day18::Part1
    part2 = Y2021::Day18::Part2

    context 'Part 1' do
        context 'unit tests' do
            it 'can explode a number' do
                tests = [
                    [ [[[[[9,8],1],2],3],4], [[[[0,9],2],3],4] ],
                    [ [7,[6,[5,[4,[3,2]]]]], [7,[6,[5,[7,0]]]] ],
                    [ [[6,[5,[4,[3,2]]]],1], [[6,[5,[7,0]]],3] ],
                    [ [[3,[2,[1,[7,3]]]],[6,[5,[4,[3,2]]]]], [[3,[2,[8,0]]],[9,[5,[7,0]]]] ],
                    [ [[3,[2,[8,0]]],[9,[5,[4,[3,2]]]]], [[3,[2,[8,0]]],[9,[5,[7,0]]]] ]
                ]

                tests.each do |input, expected|
                    output, _ = part1.explode(input)
                    expect(output).to eq expected
                end
            end
        end

        context 'examples' do
            it 'matches the numbers in the examples' do
                input = [[[[[4,3],4],4],[7,[[8,4],9]]],[1,1]]
                output = part1.reduce(input)
                expect(output).to eq [[[[0,7],4],[[7,8],[6,0]]],[8,1]]
            end

            it 'can reduce a complicated expression' do
                input = [[[[0,[4,5]],[0,0]],[[[4,5],[2,6]],[9,5]]],[7,[[[3,7],[4,3]],[[6,3],[8,8]]]]]
                output = part1.reduce(input)
                expect(output).to eq [[[[4,0],[5,4]],[[7,7],[6,0]]],[[8,[7,7]],[[7,9],[5,0]]]]
            end

            it "finds the answer to the final example" do
                sequence = [
                    [1,1],
                    [2,2],
                    [3,3],
                    [4,4]
                ]
                output = part1.sequence sequence
                expect(output).to eq [[[[1,1],[2,2]],[3,3]],[4,4]]
            end

            it "finds the answer to the final example" do
                sequence = [
                    [1,1],
                    [2,2],
                    [3,3],
                    [4,4],
                    [5,5]
                ]
                output = part1.sequence sequence
                expect(output).to eq [[[[3,0],[5,3]],[4,4]],[5,5]]
            end

            it "finds the answer to the final example" do
                sequence = [
                    [1,1],
                    [2,2],
                    [3,3],
                    [4,4],
                    [5,5],
                    [6,6]
                ]
                output = part1.sequence sequence
                expect(output).to eq [[[[5,0],[7,4]],[5,5]],[6,6]]
            end

            it 'can handle a sequence' do
                sequence = [
                    [[[0,[4,5]],[0,0]],[[[4,5],[2,6]],[9,5]]],
                    [7,[[[3,7],[4,3]],[[6,3],[8,8]]]],
                    [[2,[[0,8],[3,4]]],[[[6,7],1],[7,[1,6]]]],
                    [[[[2,4],7],[6,[0,5]]],[[[6,8],[2,8]],[[2,1],[4,5]]]],
                    [7,[5,[[3,8],[1,4]]]],
                    [[2,[2,2]],[8,[8,1]]],
                    [2,9],
                    [1,[[[9,3],9],[[9,0],[0,7]]]],
                    [[[5,[7,4]],7],1],
                    [[[[4,2],2],6],[8,7]]
                ]

                output = part1.sequence sequence
                expect(output).to eq [[[[8,7],[7,7]],[[8,6],[7,7]]],[[[0,7],[6,6]],[8,7]]]
                magnitude = part1.magnitude output
                expect(magnitude).to eq 3488
            end

            it 'can handle a sequence' do
                sequence = [
                    [[[0,[5,8]],[[1,7],[9,6]]],[[4,[1,2]],[[1,4],2]]],
                    [[[5,[2,8]],4],[5,[[9,9],0]]],
                    [6,[[[6,2],[5,6]],[[7,6],[4,7]]]],
                    [[[6,[0,7]],[0,9]],[4,[9,[9,0]]]],
                    [[[7,[6,4]],[3,[1,3]]],[[[5,5],1],9]],
                    [[6,[[7,3],[3,2]]],[[[3,8],[5,7]],4]],
                    [[[[5,4],[7,7]],8],[[8,3],8]],
                    [[9,3],[[9,9],[6,[4,9]]]],
                    [[2,[[7,7],7]],[[5,8],[[9,3],[0,2]]]],
                    [[[[5,2],5],[8,[3,7]]],[[5,[7,5]],[4,4]]]
                ]

                output = part1.sequence sequence
                expect(output).to eq [[[[6,6],[7,6]],[[7,7],[7,0]]],[[[7,7],[7,7]],[[7,8],[9,9]]]]
                magnitude = part1.magnitude output
                expect(magnitude).to eq 4140
            end

            it 'can calculate magnitude' do
                expect(part1.magnitude([[1,2],[[3,4],5]])).to eq 143
                expect(part1.magnitude([[[[0,7],4],[[7,8],[6,0]]],[8,1]])).to eq 1384
                expect(part1.magnitude([[[[1,1],[2,2]],[3,3]],[4,4]])).to eq 445
                expect(part1.magnitude([[[[3,0],[5,3]],[4,4]],[5,5]])).to eq 791
                expect(part1.magnitude([[[[5,0],[7,4]],[5,5]],[6,6]])).to eq 1137
                expect(part1.magnitude([[[[8,7],[7,7]],[[8,6],[7,7]]],[[[0,7],[6,6]],[8,7]]])).to eq 3488

            end
        end

        context "challenge" do
            it "finds the answer" do
                raw = part1.read_input
                sequence = part1.parse_input raw
                output = part1.sequence sequence
                magnitude = part1.magnitude output
                expect(magnitude).to be > 1858
            end
        end
    end

    context 'Part 2' do
        context 'unit tests' do
            it 'can extend the grid' do

            end
        end

        context "examples" do
            it 'matches the numbers in the example' do

            end
        end

        context "challenge" do
            it "finds the answer" do

            end
        end
    end
end

