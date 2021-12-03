require_relative '../../../2021/03/part1.rb'
require_relative '../../../2021/03/part2.rb'

RSpec.describe "2021/03/Part2" do
    part1 = Y2021::Day3::Part1
    part2 = Y2021::Day3::Part2

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
