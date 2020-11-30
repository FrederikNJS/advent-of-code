require 'pry'
require_relative 'part1'
System = Struct.new(:locations, :velocities)



if __FILE__ == $0
    input = File.readlines('2019/12/puzzle-input.txt').map(&:chomp)
    re = /<x=(?<x>-?\d+), y=(?<y>-?\d+), z=(?<z>-?\d+)>/
    moons_initial = input.map { |line| re.match(line) }.map { |match| Moon.new(Coord.new(match[:x].to_i, match[:y].to_i, match[:z].to_i)) }
    moons = input.map { |line| re.match(line) }.map { |match| Moon.new(Coord.new(match[:x].to_i, match[:y].to_i, match[:z].to_i)) }

    x = nil
    y = nil
    z = nil

    n = 0
    while x.nil? || y.nil? || z.nil?
        n += 1
        simulate_system_step moons
        if (x.nil? && moons_initial[0].position.x == moons[0].position.x && moons_initial[0].velocity.x == moons[0].velocity.x &&
            moons_initial[1].position.x == moons[1].position.x && moons_initial[1].velocity.x == moons[1].velocity.x &&
            moons_initial[2].position.x == moons[2].position.x && moons_initial[2].velocity.x == moons[2].velocity.x &&
            moons_initial[3].position.x == moons[3].position.x && moons_initial[3].velocity.x == moons[3].velocity.x)
            x = n
            puts "x = #{x}"
        end
        if (y.nil? && moons_initial[0].position.y == moons[0].position.y && moons_initial[0].velocity.y == moons[0].velocity.y &&
            moons_initial[1].position.y == moons[1].position.y && moons_initial[1].velocity.y == moons[1].velocity.y &&
            moons_initial[2].position.y == moons[2].position.y && moons_initial[2].velocity.y == moons[2].velocity.y &&
            moons_initial[3].position.y == moons[3].position.y && moons_initial[3].velocity.y == moons[3].velocity.y)
            y = n
            puts "y = #{y}"
        end
        if (z.nil? && moons_initial[0].position.z == moons[0].position.z && moons_initial[0].velocity.z == moons[0].velocity.z &&
            moons_initial[1].position.z == moons[1].position.z && moons_initial[1].velocity.z == moons[1].velocity.z &&
            moons_initial[2].position.z == moons[2].position.z && moons_initial[2].velocity.z == moons[2].velocity.z &&
            moons_initial[3].position.z == moons[3].position.z && moons_initial[3].velocity.z == moons[3].velocity.z)
            z = n
            puts "z = #{z}"
        end
    end
    x_div = Rational.new(1, x)
    y_div = Rational.new(1, y)
    z_div = Rational.new(1, z)
end

# too low: 645
# too high: 13484
#x 231614
