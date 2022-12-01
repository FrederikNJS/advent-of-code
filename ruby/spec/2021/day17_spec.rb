require 'immutable'
require_relative '../../2021/17/part1.rb'
require_relative '../../2021/17/part2.rb'
require 'pry'

RSpec.describe '2021 Day 17' do
    part1 = Y2021::Day17::Part1
    part2 = Y2021::Day17::Part2

    context 'Part 1' do
        context 'unit tests' do
        end

        context 'examples' do
            it 'matches the numbers in the examples' do
                target_area = [20..30, -10..-5]

                trajectory1 = part1.simulate_trajectory([7, 2], target_area)
                expect(part1.hit_target?(trajectory1.last, target_area)).to be true

                trajectory2 = part1.simulate_trajectory([6,3], target_area)
                expect(part1.hit_target?(trajectory2.last, target_area)).to be true

                trajectory3 = part1.simulate_trajectory([9,0], target_area)
                expect(part1.hit_target?(trajectory3.last, target_area)).to be true

                trajectory4 = part1.simulate_trajectory([17, -4], target_area)
                expect(part1.hit_target?(trajectory4.last, target_area)).to be false
            end

            it 'can validate the final example peak' do
                target_area = [20..30, -10..-5]

                trajectory = part1.simulate_trajectory([6,9], target_area)
                expect(part1.hit_target?(trajectory.last, target_area)).to be true
                expect(part1.extract_peak_height(trajectory)).to eq 45
            end

            it "finds the answer to the final example" do
                target_area = [20..30, -10..-5]
                all_hits = part1.simulate_all target_area
                trajectory_heights = all_hits.map {|trajectory| [trajectory.first, part1.extract_peak_height(trajectory)]}
                initial_velocity, peak = highest_trajectory = trajectory_heights.max_by{|_, height| height}
                expect(initial_velocity).to eq [6,9]
                expect(peak).to eq 45
            end
        end

        context "challenge" do
            it "finds the answer" do
                target_area = [85..145, -163..-108]
                all_hits = part1.simulate_all target_area
                trajectory_heights = all_hits.map {|trajectory| [trajectory.first, part1.extract_peak_height(trajectory)]}
                initial_velocity, peak = highest_trajectory = trajectory_heights.max_by{|_, height| height}
                expect(initial_velocity).to eq [13,162]
                expect(peak).to eq 13203
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
                target_area = [20..30, -10..-5]
                all_hits = part1.simulate_all target_area
                expect(all_hits.count).to eq 112
            end
        end

        context "challenge" do
            it "finds the answer" do
                target_area = [85..145, -163..-108]
                all_hits = part1.simulate_all target_area
                expect(all_hits.count).to eq 5644
            end
        end
    end
end
