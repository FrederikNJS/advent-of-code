require_relative '../../../2021/02/part1.rb'

RSpec.describe "2021/03/Part1" do
    part1 = Y2021::Day2::Part1

    context "unit tests" do
        it 'read input' do
        end
    end

    context "examples" do
        it 'matches the numbers in the example' do
            sample_input = [
                'forward 5',
                'down 5',
                'forward 8',
                'up 3',
                'down 8',
                'forward 2"',
            ]

            entries = part1.parse_input (sample_input)

            distance, depth = part1.count_depth_and_distance entries

            expect(distance).to equal 15
            expect(depth).to equal 10
            expect(distance * depth).to equal 150
        end
    end

    context "challenge" do
        it "finds the answer" do
            raw_input = part1.read_input

            entries = part1.parse_input (raw_input)

            distance, depth = part1.count_depth_and_distance entries

            expect(distance).to equal 1968
            expect(depth).to equal 1063
            expect(distance * depth).to equal 2091984
        end
    end
end
