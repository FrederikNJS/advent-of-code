require_relative '../../../2019/10/part2.rb'

RSpec.describe '2019/10/Part1' do
    it 'it can calculate asteroid angles' do
        origin = Asteroid.new(1,1)

        n = Asteroid.new(1,0)
        ne = Asteroid.new(2,0)
        e = Asteroid.new(2,1)
        se = Asteroid.new(2,2)
        s = Asteroid.new(1,2)
        sw = Asteroid.new(0,2)
        w = Asteroid.new(0,1)
        nw = Asteroid.new(0,0)

        expect(asteroid_angle(origin, n)).to eq 0
        expect(asteroid_angle(origin, ne)).to eq 45
        expect(asteroid_angle(origin, e)).to eq 90
        expect(asteroid_angle(origin, se)).to eq 135
        expect(asteroid_angle(origin, s)).to eq 180
        expect(asteroid_angle(origin, sw)).to eq 225
        expect(asteroid_angle(origin, w)).to eq 270
        expect(asteroid_angle(origin, nw)).to eq 315
    end
end
