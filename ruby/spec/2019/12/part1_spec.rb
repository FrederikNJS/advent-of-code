require_relative '../../../2019/12/part1.rb'

RSpec.describe '2019/12/Part1' do
    part1 = Y2019::Day12::Part1
    it 'can calculate the gravity difference between two moons' do
        moon_a = part1::Moon.new(part1::Coord.new(-1, 0, 2))
        moon_b = part1::Moon.new(part1::Coord.new(2, -10, -7))

        moon_a.apply_gravity moon_b
        moon_b.apply_gravity moon_a

        expect(moon_a.velocity).to eq(part1::Coord.new(1, -1, -1))
        expect(moon_b.velocity).to eq(part1::Coord.new(-1, 1, 1))

        moon_a.update_location
        moon_b.update_location

        expect(moon_a.position).to eq(part1::Coord.new(0, -1, 1))
        expect(moon_b.position).to eq(part1::Coord.new(1, -9, -6))
    end

    it 'can simulate a system step' do
        moons = [
            part1::Moon.new(part1::Coord.new(-1, 0, 2)),
            part1::Moon.new(part1::Coord.new(2, -10, -7)),
            part1::Moon.new(part1::Coord.new(4, -8, 8)),
            part1::Moon.new(part1::Coord.new(3, 5, -1))
        ]

        part1.simulate_system_step moons

        expect(moons[0].position).to eq part1::Coord.new(2, -1, 1)
        expect(moons[1].position).to eq part1::Coord.new(3, -7, -4)
        expect(moons[2].position).to eq part1::Coord.new(1, -7, 5)
        expect(moons[3].position).to eq part1::Coord.new(2, 2, 0)

        expect(moons[0].velocity).to eq part1::Coord.new(3, -1, -1)
        expect(moons[1].velocity).to eq part1::Coord.new(1, 3, 3)
        expect(moons[2].velocity).to eq part1::Coord.new(-3, 1, -3)
        expect(moons[3].velocity).to eq part1::Coord.new(-1, -3, 1)
    end

    it 'can simulate multiple steps at a time' do
        moons = [
            part1::Moon.new(part1::Coord.new(-1, 0, 2)),
            part1::Moon.new(part1::Coord.new(2, -10, -7)),
            part1::Moon.new(part1::Coord.new(4, -8, 8)),
            part1::Moon.new(part1::Coord.new(3, 5, -1))
        ]

        part1.simulate_system moons, 10

        expect(moons[0].position).to eq part1::Coord.new(2,  1, -3)
        expect(moons[1].position).to eq part1::Coord.new(1, -8,  0)
        expect(moons[2].position).to eq part1::Coord.new(3, -6,  1)
        expect(moons[3].position).to eq part1::Coord.new(2,  0,  4)

        expect(moons[0].velocity).to eq part1::Coord.new(-3, -2,  1)
        expect(moons[1].velocity).to eq part1::Coord.new(-1,  1,  3)
        expect(moons[2].velocity).to eq part1::Coord.new( 3,  2, -3)
        expect(moons[3].velocity).to eq part1::Coord.new( 1, -1, -1)
    end
end
