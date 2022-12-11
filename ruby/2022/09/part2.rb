require_relative 'part1.rb'

module Y2022
    module Day09
        module Part2
            @part1 = Y2022::Day09::Part1

            def self.solve input=nil
                input = @part1.read_input unless input
                instructions = @part1.parse_instructions input
                snake = [
                    {x: 0, y: 0},
                    {x: 0, y: 0},
                    {x: 0, y: 0},
                    {x: 0, y: 0},
                    {x: 0, y: 0},
                    {x: 0, y: 0},
                    {x: 0, y: 0},
                    {x: 0, y: 0},
                    {x: 0, y: 0},
                    {x: 0, y: 0}
                ]
                visit_set = @part1.perform_instructions snake, instructions
                visit_set.size
            end
        end
    end
end
