require_relative '../../../2021/01/part1.rb'
require_relative '../../../2021/01/part2.rb'

RSpec.describe "2021/01/Part1" do
    part1 = Y2021::Day1::Part1
    part2 = Y2021::Day1::Part2

    context "examples" do
        it 'matches the numbers in the example' do
            example_values = [199,200,208,210,200,207,240,269,260,263]
            increase_count = part2.detect_window_increases example_values
            expect(increase_count).to equal 5
        end
    end

    context "challenge" do
        it "finds the answer" do
            input = part1.read_input
            increase_count = part2.detect_window_increases input
            expect(increase_count).to equal 1130
        end
    end
end
