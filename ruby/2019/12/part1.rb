require 'pry'

module Y2019
    module Day12
        module Part1
            Coord = Struct.new(:x, :y, :z)

            class Moon
                attr_accessor :velocity, :position

                def initialize(position, velocity=nil)
                    @position = position
                    @velocity = if velocity.nil?
                        Coord.new(0, 0, 0)
                    else
                        velocity
                    end
                end

                def apply_gravity(other)
                    @velocity.x += other.position.x <=> @position.x
                    @velocity.y += other.position.y <=> @position.y
                    @velocity.z += other.position.z <=> @position.z
                end

                def apply_gravity_x(other)
                    @velocity.x += other.position.x <=> @position.x
                end

                def apply_gravity_y(other)
                    @velocity.y += other.position.y <=> @position.y
                end

                def apply_gravity_z(other)
                    @velocity.z += other.position.z <=> @position.z
                end

                def update_location
                    @position.x += @velocity.x
                    @position.y += @velocity.y
                    @position.z += @velocity.z
                end

                def update_location_x
                    @position.x += @velocity.x
                end

                def update_location_y
                    @position.x += @velocity.x
                end

                def update_location_z
                    @position.x += @velocity.x
                end

                def potential_energy
                    @position.x.abs + @position.y.abs + @position.z.abs
                end

                def kinetic_energy
                    @velocity.x.abs + @velocity.y.abs + @velocity.z.abs
                end

                def total_energy
                    self.potential_energy * self.kinetic_energy
                end
            end

            def self.simulate_system_step(moons)
                moons.combination(2).each do |moon_a, moon_b|
                    moon_a.apply_gravity moon_b
                    moon_b.apply_gravity moon_a
                end

                moons.each do |moon|
                    moon.update_location
                end
            end

            def self.simulate_system(moons, steps)
                steps.times do |time|
                    simulate_system_step moons
                end
            end

            if __FILE__ == $0
                input = File.readlines('2019/12/puzzle-input.txt').map(&:chomp)
                re = /<x=(?<x>-?\d+), y=(?<y>-?\d+), z=(?<z>-?\d+)>/
                moons = input.map { |line| re.match(line) }.map { |match| Moon.new(Coord.new(match[:x].to_i, match[:y].to_i, match[:z].to_i)) }
                simulate_system(moons, 1000)
                puts moons.map { |moon| moon.total_energy }.sum

            end

            # too low: 645
            # too high: 13484
        end
    end
end