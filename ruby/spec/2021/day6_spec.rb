require 'pry'
require_relative '../../2021/06/part1.rb'
require_relative '../../2021/06/part2.rb'

RSpec.describe "2021 Day 06" do
    part1 = Y2021::Day6::Part1
    part2 = Y2021::Day6::Part2
    context 'Part 1' do


        context "unit tests" do
            it 'can progress a day' do
                fish_d1 = [3, 4, 3, 1, 2]
                fish_d2 = part1.progress_a_day fish_d1
                expect(fish_d2).to eq [2, 3, 2, 0, 1]
            end

            it 'can progress a day and add new fish' do
                fish_d1 = [2, 3, 2, 0, 1]
                fish_d2 = part1.progress_a_day fish_d1
                expect(fish_d2).to eq [1,2,1,6,0,8]
            end
        end

        context "examples" do
            it 'matches the numbers in the first example' do
                fish = [3, 4, 3, 1, 2]
                18.times do
                    fish = part1.progress_a_day fish
                end
                expect(fish.length).to eq 26
            end

            it 'matches the numbers in the second example' do
                fish = [3, 4, 3, 1, 2]
                80.times do
                    fish = part1.progress_a_day fish
                end
                expect(fish.length).to eq 5934
            end
        end

        context "challenge" do
            it "finds the answer" do
                raw = part1.read_input
                fish = part1.parse_input raw
                80.times do
                    fish = part1.progress_a_day fish
                end
                expect(fish.length).to eq 386640
            end

            it "finds the answer with part2 method" do
                raw = part1.read_input
                fishes = part1.parse_input raw
                fishes_age_groups = part2.convert_to_age_groups fishes
                80.times do
                    fishes_age_groups = part2.progress_a_day_on_age_groups fishes_age_groups
                end
                expect(fishes_age_groups.values.sum).to eq 386640
            end
        end
    end

    context 'Part 2' do
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
end
