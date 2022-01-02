require 'immutable'
require 'pry'

module Y2021
    module Day15
        module Part1


            def self.read_input
                File.read('2021/15/puzzle-input.txt').chomp
            end

            def self.parse_input raw
                raw.lines.map.with_index {|l, row| l.chomp.chars.map.with_index {|c, column| [[row, column], c.to_i]} }.flatten(1).to_h
            end

            def self.get_dimensions raw
                [raw.lines.size, raw.lines[0].chomp.size]
            end

            def self.neighbors coord
                x, y = coord
                [
                    [x-1, y],
                    [x+1, y],
                    [x, y-1],
                    [x, y+1]
                ]
            end

            def self.build_reverse_refs grid, origin
                reverse_paths = Hash.new
                reverse_paths[origin] = [0, nil]

                queue = Queue.new
                queue << [0, origin]

                until queue.empty?
                    current_weight, current_coord = queue.pop

                    neighbors = self.neighbors(current_coord).filter{|coord| grid.has_key? coord }
                    neighbors.each do |coord|
                        new_weight = current_weight + grid[coord]
                        if !reverse_paths.has_key?(coord) || reverse_paths[coord][0] > new_weight
                            reverse_paths[coord] = [new_weight, current_coord]
                            queue << [new_weight, coord]
                        end
                    end
                end

                reverse_paths
            end
        end
    end
end
