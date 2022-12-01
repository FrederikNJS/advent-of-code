require 'pqueue'
require_relative './part1'

module Y2021
    module Day15
        module Part2
            def self.extend_grid grid, dims
                new_grid = grid.dup

                for x in 0...(dims[0] * 5)
                    for y in 0...(dims[1] * 5)

                        new_grid[[x, y]] = (((grid[[x % dims[0], y % dims[1]]] - 1) + (x / dims[0]) + (y / dims[1])) % 9) + 1
                    end
                end

                new_grid
            end

            def self.dist_to_target coord, target
                (target[0] - coord[0]).abs + (target[1] - coord[1]).abs
            end

            def self.reconstruct_path(cameFrom, current)
                total_path = [current]
                while cameFrom.has_key? current
                    current = cameFrom[current]
                    total_path.prepend(current)
                end
                total_path
            end

            def self.a_star grid, origin, target
                cameFrom = Hash.new
                gScore = Hash.new(Float::INFINITY)
                gScore[origin] = 0
                fScore = Hash.new(Float::INFINITY)
                fScore[origin] = self.dist_to_target(origin, target)
                openSet = PQueue.new {|a, b| fScore[a] < fScore[b]}
                openSet << origin
                until openSet.empty?
                    current = openSet.pop
                    if current == target
                        return reconstruct_path(cameFrom, current)
                    end
                    Y2021::Day15::Part1.neighbors(current).filter{|coord| grid.has_key? coord}.each do |neighbor|
                        tentative_gScore = gScore[current] + grid[neighbor]
                        if tentative_gScore < gScore[neighbor]
                            cameFrom[neighbor] = current
                            gScore[neighbor] = tentative_gScore
                            fScore[neighbor] = tentative_gScore + self.dist_to_target(neighbor, target)
                            if !neighbor.include?(neighbor)
                                openSet << neighbor
                            end
                        end
                    end
                end
                return nil
            end
        end
    end
end
