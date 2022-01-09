require 'immutable'
require 'pry'

module Y2021
    module Day17
        module Part1
            def self.hit_target?(coord, target)
                x_loc, y_loc = coord
                x_target, y_target = target
                x_target.cover?(x_loc) && y_target.cover?(y_loc)
            end

            def self.out?(coord, target)
                x_loc, y_loc = coord
                x_target, y_target = target
                x_loc > x_target.max || y_loc < y_target.min
            end

            def self.simulate_trajectory(velocity, target)
                x_vel, y_vel = velocity
                x_loc = 0
                y_loc = 0
                positions = []
                until self.out?([x_loc, y_loc], target) || self.hit_target?([x_loc, y_loc], target)
                    x_loc += x_vel
                    y_loc += y_vel
                    if x_vel > 0
                        x_vel -= 1
                    elsif x_vel < 0
                        x_vel += 1
                    end
                    y_vel -= 1
                    positions << [x_loc, y_loc]
                end
                positions
            end

            def self.extract_peak_height(trajectory)
                trajectory.map{|a, b| b}.max
            end

            def self.simulate_all(target)
                x_target, y_target = target
                x_velocities = (1..x_target.max).to_a
                y_velocities = ((y_target.min)..([y_target.min.abs, y_target.max.abs].max)).to_a

                x_velocities.product(y_velocities).map do |x, y|
                    self.simulate_trajectory([x,y], target)
                end.filter do |trajectory|
                    self.hit_target?(trajectory.last, target)
                end

            end

            def self.read_input
                File.read('2021/17/puzzle-input.txt').chomp
            end

            def self.parse_input raw

            end
        end
    end
end
