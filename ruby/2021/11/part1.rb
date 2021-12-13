require 'pry'

module Y2021
    module Day11
        module Part1
            def self.read_input
                File.readlines('2021/11/puzzle-input.txt').map(&:chomp)
            end

            def self.parse_input raw
                self.grid_to_map(raw.map {|line| line.chars.map{|char| char.to_i}})
            end

            def self.grid_to_map grid
                hash = Hash.new
                grid.each_with_index do |row, row_idx|
                    row.each_with_index do |cell, col_idx|
                        hash[[row_idx, col_idx]] = cell
                    end
                end
                hash
            end

            def self.step input
                incremented = input.map {|coord, value| [coord, value+1]}.to_h
                queue = Queue.new
                incremented.filter {|coord, value| value >= 10}.each {|coord, value| queue << coord}
                flashers = Set.new
                until queue.empty?
                    flasher = queue.pop
                    flashers << flasher
                    x, y = flasher
                    neighbors = [
                        [x-1, y-1],
                        [x-1, y],
                        [x-1, y+1],
                        [x, y-1],
                        [x, y+1],
                        [x+1, y-1],
                        [x+1, y],
                        [x+1, y+1]
                    ]
                    neighbors.each do |coord|
                        if incremented.has_key?(coord) && !flashers.include?(coord)
                            incremented[coord] += 1
                            if incremented[coord] == 10
                                queue << coord
                            end
                        end
                    end
                end
                [incremented.map {|coord, value| [coord, value >= 10 ? 0 : value]}.to_h, flashers.size]
            end
        end
    end
end
