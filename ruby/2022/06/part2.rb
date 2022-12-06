require_relative 'part1.rb'

module Y2022
    module Day6
        module Part2
            @part1 = Y2022::Day6::Part1

            def self.solve input=nil
                input = @part1.read_input unless input
                @part1.find_first_marker input, 14
            end
        end
    end
end
