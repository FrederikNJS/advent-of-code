require 'pry'
require_relative '../../../2021/06/part1.rb'
require_relative '../../../2021/06/part2.rb'

RSpec.describe "2021/06/Part2" do
    part1 = Y2021::Day6::Part1
    part2 = Y2021::Day6::Part2

    context 'unit tests' do
        it 'can convert a list of fish to an age group hash' do
            fishes = [3, 4, 3, 1, 2]
            age_groups = part2.convert_to_age_groups fishes
            expect(age_groups).to eq ({
                1 => 1,
                2 => 1,
                3 => 2,
                4 => 1
            })
        end
    end

    context "examples" do
        it 'matches the numbers in the example' do
            fishes = [3, 4, 3, 1, 2]
            fishes_age_groups = part2.convert_to_age_groups fishes
            256.times do
                fishes_age_groups = part2.progress_a_day_on_age_groups fishes_age_groups
            end
            expect(fishes_age_groups.values.sum).to eq 26984457539
        end
    end

    context "challenge" do
        it "finds the answer" do
            raw = part1.read_input
            fishes = part1.parse_input raw
            fishes_age_groups = part2.convert_to_age_groups fishes
            256.times do
                fishes_age_groups = part2.progress_a_day_on_age_groups fishes_age_groups
            end
            expect(fishes_age_groups.values.sum).to eq 1733403626279
        end
    end
end
