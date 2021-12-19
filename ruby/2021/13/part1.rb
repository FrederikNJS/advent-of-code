require 'immutable'
require 'pry'

module Y2021
    module Day13
        module Part1
            def self.read_input
                File.read('2021/13/puzzle-input.txt').chomp
            end

            def self.parse_input raw
                coordinate_lines, instruction_lines = raw.split("\n\n").map {|part| part.lines}
                coordinates = coordinate_lines.map {|line| line.split(",").map{|item| item.to_i}}.to_set
                instruction_pattern = /fold along (.)=(.*)/
                instructions = instruction_lines.map do |line|
                    match = instruction_pattern.match(line)
                    [match.captures[0], match.captures[1].to_i]
                end
                [coordinates, instructions]
            end

            def self.fold_once coordinates, instruction
                coordinates.map do |x,y|
                    if instruction[0] == "x"
                        [x > instruction[1] ? instruction[1]-x+instruction[1] : x, y]
                    else
                        [x, y > instruction[1] ? instruction[1]-y+instruction[1] : y]
                    end
                end.to_set
            end

            def self.fold_all coordinates, instructions
                instructions.reduce(coordinates) {|coordinates_iter, instruction| self.fold_once(coordinates_iter, instruction) }
            end

            def self.print coordinates
                maxx = coordinates.map{|x,y| x}.max
                maxy = coordinates.map{|x,y| y}.max
                array = Array.new(maxx+1) {Array.new(maxy+1, " ")}
                coordinates.each {|x,y| array[x][y] = '#'}
                array.transpose.map{|line| line.join}.join("\n")
            end
        end
    end
end
