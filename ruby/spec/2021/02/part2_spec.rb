require_relative '../../../2021/02/part1.rb'
require_relative '../../../2021/02/part2.rb'

RSpec.describe "2021/02/Part2" do
    part1 = Y2021::Day2::Part1
    part2 = Y2021::Day2::Part2

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

            distance, depth = part2.calculate_depth_and_distance entries

            expect(distance).to equal 15
            expect(depth).to equal 60
            expect(distance * depth).to equal 900
        end
    end

    context "challenge" do
        it "finds the answer" do
            raw_input = part1.read_input

            entries = part1.parse_input (raw_input)

            distance, depth = part2.calculate_depth_and_distance entries

            expect(distance).to equal 1968
            expect(depth).to equal 1060092
            expect(distance * depth).to equal 2086261056
        end
    end
end
