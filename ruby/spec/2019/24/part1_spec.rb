require_relative '../../../2019/24/part1.rb'
require 'pry'

RSpec.describe '2019/24/Part1' do
    it 'makes the world evolve' do
        world = [
            ['.', '.', '.', '.', '#'],
            ['#', '.', '.', '#', '.'],
            ['#', '.', '.', '#', '#'],
            ['.', '.', '#', '.', '.'],
            ['#', '.', '.', '.', '.'],
        ]

        expected_minute_1 = [
            ['#', '.', '.', '#', '.'],
            ['#', '#', '#', '#', '.'],
            ['#', '#', '#', '.', '#'],
            ['#', '#', '.', '#', '#'],
            ['.', '#', '#', '.', '.'],
        ]
        minute_1 = Day201924.step(world)
        expect(minute_1).to eq expected_minute_1


        expected_minute_2 = [
            ['#', '#', '#', '#', '#'],
            ['.', '.', '.', '.', '#'],
            ['.', '.', '.', '.', '#'],
            ['.', '.', '.', '#', '.'],
            ['#', '.', '#', '#', '#'],
        ]
        minute_2 = Day201924.step(minute_1)
        expect(minute_2).to eq expected_minute_2

        expected_minute_3 = [
            ['#', '.', '.', '.', '.'],
            ['#', '#', '#', '#', '.'],
            ['.', '.', '.', '#', '#'],
            ['#', '.', '#', '#', '.'],
            ['.', '#', '#', '.', '#'],
        ]
        minute_3 = Day201924.step(minute_2)
        expect(minute_3).to eq expected_minute_3

        expected_minute_4 = [
            ['#', '#', '#', '#', '.'],
            ['.', '.', '.', '.', '#'],
            ['#', '#', '.', '.', '#'],
            ['.', '.', '.', '.', '.'],
            ['#', '#', '.', '.', '.'],
        ]
        minute_4 = Day201924.step(minute_3)
        expect(minute_4).to eq expected_minute_4
    end

    it 'detects cycles' do
        world = [
            ['.', '.', '.', '.', '#'],
            ['#', '.', '.', '#', '.'],
            ['#', '.', '.', '#', '#'],
            ['.', '.', '#', '.', '.'],
            ['#', '.', '.', '.', '.'],
        ]

        expected_cycle = [
            ['.', '.', '.', '.', '.'],
            ['.', '.', '.', '.', '.'],
            ['.', '.', '.', '.', '.'],
            ['#', '.', '.', '.', '.'],
            ['.', '#', '.', '.', '.'],
        ]

        cycle = Day201924.find_first_cycle(world)

        expect(cycle).to eq expected_cycle
    end

    it 'calculates biodiversity' do
        expected_cycle = [
            ['.', '.', '.', '.', '.'],
            ['.', '.', '.', '.', '.'],
            ['.', '.', '.', '.', '.'],
            ['#', '.', '.', '.', '.'],
            ['.', '#', '.', '.', '.'],
        ]

        expect(Day201924.calculate_biodiversity(expected_cycle)).to eq 2129920
    end
end
