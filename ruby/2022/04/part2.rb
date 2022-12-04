require_relative 'part1.rb'

module Y2022
    module Day4
        module Part2
            @part1 = Y2022::Day4::Part1

            def self.range_overlaps? a, b
                b.begin <= a.end && a.begin <= b.end
            end

            def self.solve input=nil
                input = @part1.read_input unless input
                parsed = @part1.parse_input input
                overlapping = parsed.filter{|pair| self.range_overlaps?(*pair)}
                overlapping.size
            end
        end
    end
end
