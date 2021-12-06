require 'pry'
require_relative '../../../2021/06/part1.rb'

RSpec.describe "2021/06/Part1" do
    part1 = Y2021::Day6::Part1

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
    end
end
