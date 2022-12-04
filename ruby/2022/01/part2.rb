require_relative 'part1.rb'

module Y2022
    module Day1
        module Part2
            @part1 = Y2022::Day1::Part1

            def self.solve input=nil
                input = @part1.read_input unless input
                parsed = @part1.parse_input input
                chunks = @part1.split_elves parsed
                sums = @part1.sum_elves chunks
                sorted = sums.sort.reverse
                sorted[0..2].sum
            end
        end
    end
end
