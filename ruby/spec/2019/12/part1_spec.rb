require_relative '../../../2019/12/part1.rb'

RSpec.xdescribe '2019/12/Part1' do
    it 'can calculate the gravity difference between two moons' do
        moon_a = Moon.new(Coord.new(-1, 0, 2))
        moon_b = Moon.new(Coord.new(2, -10, -7))

        moon_a.apply_gravity moon_b
        moon_b.apply_gravity moon_a

        expect(moon_a.velocity).to eq(Coord.new(1, -1, -1))
        expect(moon_b.velocity).to eq(Coord.new(-1, 1, 1))

        moon_a.update_location
        moon_b.update_location

        expect(moon_a.position).to eq(Coord.new(0, -1, 1))
        expect(moon_b.position).to eq(Coord.new(1, -9, -6))
    end

    it 'can simulate a system step' do
        moons = [
            Moon.new(Coord.new(-1, 0, 2)),
            Moon.new(Coord.new(2, -10, -7)),
            Moon.new(Coord.new(4, -8, 8)),
            Moon.new(Coord.new(3, 5, -1))
        ]

        simulate_system_step moons

        expect(moons[0].position).to eq Coord.new(2, -1, 1)
        expect(moons[1].position).to eq Coord.new(3, -7, -4)
        expect(moons[2].position).to eq Coord.new(1, -7, 5)
        expect(moons[3].position).to eq Coord.new(2, 2, 0)

        expect(moons[0].velocity).to eq Coord.new(3, -1, -1)
        expect(moons[1].velocity).to eq Coord.new(1, 3, 3)
        expect(moons[2].velocity).to eq Coord.new(-3, 1, -3)
        expect(moons[3].velocity).to eq Coord.new(-1, -3, 1)
    end

    it 'can simulate multiple steps at a time' do
        moons = [
            Moon.new(Coord.new(-1, 0, 2)),
            Moon.new(Coord.new(2, -10, -7)),
            Moon.new(Coord.new(4, -8, 8)),
            Moon.new(Coord.new(3, 5, -1))
        ]

        simulate_system moons, 10

        expect(moons[0].position).to eq Coord.new(2,  1, -3)
        expect(moons[1].position).to eq Coord.new(1, -8,  0)
        expect(moons[2].position).to eq Coord.new(3, -6,  1)
        expect(moons[3].position).to eq Coord.new(2,  0,  4)

        expect(moons[0].velocity).to eq Coord.new(-3, -2,  1)
        expect(moons[1].velocity).to eq Coord.new(-1,  1,  3)
        expect(moons[2].velocity).to eq Coord.new( 3,  2, -3)
        expect(moons[3].velocity).to eq Coord.new( 1, -1, -1)
        binding.pry
    end
end
