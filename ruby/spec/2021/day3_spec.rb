require_relative '../../2021/03/part1.rb'
require_relative '../../2021/03/part2.rb'

RSpec.describe "2021 Day 03" do
    part1 = Y2021::Day3::Part1
    part2 = Y2021::Day3::Part2

    context 'Part 1' do
        context "unit tests" do
            it 'read input' do
                raw_input = [
                    "1001",
                    "1010"
                ]

                parsed = part1.parse_input(raw_input)
                expect(parsed).to eq [9, 10]
            end
        end

        context "examples" do
            it 'matches the numbers in the example' do
                sample_data = [
                    "00100",
                    "11110",
                    "10110",
                    "10111",
                    "10101",
                    "01111",
                    "00111",
                    "11100",
                    "10000",
                    "11001",
                    "00010",
                    "01010",
                ]
                input = part1.parse_input sample_data
                gamma_rate, epsilon_rate = part1.calculate_diagnostics input, 5
                expect(gamma_rate).to equal 0b10110
                expect(epsilon_rate).to equal 0b01001
            end
        end

        context "challenge" do
            it "finds the answer" do
                data = part1.read_input
                input = part1.parse_input data
                gamma_rate, epsilon_rate = part1.calculate_diagnostics input, 12
                expect(gamma_rate).to equal 0b101111111101
                expect(epsilon_rate).to equal 0b010000000010
                expect(gamma_rate * epsilon_rate).to equal 0b1100000000101111111010
                expect(gamma_rate * epsilon_rate).to equal 3148794
            end
        end
    end

    context 'Part 2' do
        context "unit tests" do

        end

        context "examples" do
            it 'matches the numbers in the example' do
                sample_data = [
                    "00100",
                    "11110",
                    "10110",
                    "10111",
                    "10101",
                    "01111",
                    "00111",
                    "11100",
                    "10000",
                    "11001",
                    "00010",
                    "01010",
                ]
                input = part1.parse_input sample_data
                oxygen_generator_rating = part2.find_oxygen_generator_rating input, 5
                expect(oxygen_generator_rating).to equal 0b10111

                co2_scrubber_rating = part2.find_co2_scrubber_rating input, 5
                expect(co2_scrubber_rating).to equal 0b01010

                expect(oxygen_generator_rating * co2_scrubber_rating).to equal 230
            end
        end

        context "challenge" do
            it "finds the answer" do
                data = part1.read_input
                input = part1.parse_input data
                oxygen_generator_rating = part2.find_oxygen_generator_rating input, 12
                expect(oxygen_generator_rating).to equal 0b100100101101

                co2_scrubber_rating = part2.find_co2_scrubber_rating input, 12
                expect(co2_scrubber_rating).to equal 0b10010100110

                expect(oxygen_generator_rating * co2_scrubber_rating).to equal 2795310
            end
        end
    end

end
