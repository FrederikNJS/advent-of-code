require_relative 'part1.rb'

module Y2022
    module Day8
        module Part2
            @part1 = Y2022::Day8::Part1

            def self.calculate_scenic_score grid, x, y
                north_range = (0...y).to_a.reverse
                south_range = (y+1)...(grid[0].size)
                east_range = (x+1)...(grid.size)
                west_range = (0...x).to_a.reverse

                north_score = 0
                for y_test in north_range
                    case grid[y_test][x]
                    when 0...grid[y][x]
                        north_score += 1
                    when grid[y][x]..9
                        north_score += 1
                        break
                    end
                end

                south_score = 0
                for y_test in south_range
                    case grid[y_test][x]
                    when 0...grid[y][x]
                        south_score += 1
                    when grid[y][x]..9
                        south_score += 1
                        break
                    end
                end

                east_score = 0
                for x_test in east_range
                    case grid[y][x_test]
                    when 0...grid[y][x]
                        east_score += 1
                    when grid[y][x]..9
                        east_score += 1
                        break
                    end
                end

                west_score = 0
                for x_test in west_range
                    case grid[y][x_test]
                    when 0...grid[y][x]
                        west_score += 1
                    when grid[y][x]..9
                        west_score += 1
                        break
                    end
                end
                north_score * south_score * east_score * west_score
            end

            def self.find_best_scenic_score grid
                (0...grid.size).map do |y|
                    (0...grid[0].size).map do |x|
                        self.calculate_scenic_score grid, x, y
                    end.max
                end.max
            end

            def self.solve input=nil
                input = @part1.read_input unless input
                grid = @part1.parse_grid input
                self.find_best_scenic_score grid
            end
        end
    end
end
