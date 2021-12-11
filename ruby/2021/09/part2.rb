module Y2021
    module Day9
        module Part2
            def self.create_basins input, low_points
                queue = Queue.new
                closest_minimum = Hash.new
                low_points.each do |coord, _|
                    queue << coord
                    closest_minimum[coord] = coord
                end
                until queue.empty?
                    row, column = queue.pop
                    neighbors = [
                        [row-1, column],
                        [row+1, column],
                        [row, column-1],
                        [row, column+1]
                    ]
                    neighbors.each do |coord_to_check|
                        if !closest_minimum.has_key?(coord_to_check) && input[coord_to_check] != 9
                            closest_minimum[coord_to_check] = closest_minimum[[row, column]]
                            queue.push(coord_to_check)
                        end
                    end
                end
                closest_minimum
            end

            def self.biggest_3_basins closest_minimums
                closest_minimums.group_by { |current, minimum| minimum }.map{|minimum,coords| [minimum, coords.count]}.to_h.values.sort.reverse.take(3)
            end
        end
    end
end
