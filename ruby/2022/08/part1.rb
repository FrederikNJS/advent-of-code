require 'pry'
require 'json'

module Y2022
    module Day8
        module Part1
            def self.read_input
                File.readlines('2022/08/puzzle-input.txt').map(&:chomp)
            end

            def self.parse_grid input
                input.map{|line| line.chars.map{|char| char.to_i}}
            end

            def self.tree_is_visible? grid, x, y
                return true if x == 0 || x == grid[0].size - 1 || y == 0 || y == grid.size - 1
                north_range = 0...y
                south_range = (y+1)...(grid[0].size)
                west_range = 0...x
                east_range = (x+1)...(grid.size)

                north_visible = north_range.all? {|y_test| grid[y_test][x] < grid[y][x]}
                south_visible = south_range.all? {|y_test| grid[y_test][x] < grid[y][x]}
                east_visible = east_range.all? {|x_test| grid[y][x_test] < grid[y][x]}
                west_visible = west_range.all? {|x_test| grid[y][x_test] < grid[y][x]}
                north_visible | south_visible | east_visible | west_visible
            end

            def self.count_visible_trees grid
                count = 0
                (0...grid.size).each do |y|
                    (0...grid[0].size).each do |x|
                        if self.tree_is_visible? grid, x, y
                            count += 1
                        end
                    end
                end
                count
            end

            def self.solve input=nil
                input = self.read_input unless input
                grid = self.parse_grid input
                self.count_visible_trees grid
            end
        end
    end
end
