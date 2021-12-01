require_relative '../../../2021/01/part1.rb'

RSpec.describe "2021/01/Part1" do
    part1 = Y2021::Day1::Part1

    context "unit tests" do
        it 'read input' do
            input = part1.read_input
            expect(input.length).to equal 2000
        end

        it 'detect increase' do
            values = [1, 2, 4, 3, 5, -1, 0]
            increase_count = part1.detect_increases values
            expect(increase_count).to equal 4
        end
    end

    context "examples" do
        it 'matches the numbers in the example' do
            example_values = [199,200,208,210,200,207,240,269,260,263]
            increase_count = part1.detect_increases example_values
            expect(increase_count).to equal 7
        end
    end

    context "challenge" do
        it "finds the answer" do
            input = part1.read_input
            increase_count = part1.detect_increases input
            expect(increase_count).to equal 1167
        end
    end
end
