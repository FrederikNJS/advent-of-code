require 'pry'
require 'json'

module Y2022
    module Day09
        module Part1
            def self.read_input
                File.readlines('2022/09/puzzle-input.txt').map(&:chomp)
            end

            def self.parse_instructions input
                input.map {|line| line.split(' ') }.map {|a, b| [a, b.to_i]}
            end

            def self.reconcile_snake snake
                (1...snake.size).each do |index|
                    head = snake[index-1]
                    tail = snake[index]
                    x_diff = head[:x] - tail[:x]
                    y_diff = head[:y] - tail[:y]

                    case
                    when (x_diff == 2 && y_diff == 1) || (x_diff == 1 && y_diff == 2) || (x_diff == 2 && y_diff == 2)
                        tail[:x] += 1
                        tail[:y] += 1
                    when (x_diff == -2 && y_diff == 1) || (x_diff == -1 && y_diff == 2) || (x_diff == -2 && y_diff == 2)
                        tail[:x] -= 1
                        tail[:y] += 1
                    when (x_diff == 2 && y_diff == -1) || (x_diff == 1 && y_diff == -2) || (x_diff == 2 && y_diff == -2)
                        tail[:x] += 1
                        tail[:y] -= 1
                    when (x_diff == -2 && y_diff == -1) || (x_diff == -1 && y_diff == -2) || (x_diff == -2 && y_diff == -2)
                        tail[:x] -= 1
                        tail[:y] -= 1
                    when (x_diff == 2)
                        tail[:x] += 1
                    when (x_diff == -2)
                        tail[:x] -= 1
                    when (y_diff == 2)
                        tail[:y] += 1
                    when (y_diff == -2)
                        tail[:y] -= 1
                    end
                end
            end

            def self.perform_move snake, direction, distance, visit_set=nil
                distance.times do
                    case direction
                    when 'U'
                        snake[0][:y] += 1
                    when 'D'
                        snake[0][:y] -= 1
                    when 'L'
                        snake[0][:x] -= 1
                    when 'R'
                        snake[0][:x] += 1
                    end
                    self.reconcile_snake snake
                    visit_set << snake.last.clone if visit_set
                end
            end

            def self.perform_instructions snake, instructions
                visit_set = Set.new
                instructions.each do |instruction|
                    self.perform_move snake, *instruction, visit_set
                end
                visit_set
            end

            def self.solve input=nil
                input = self.read_input unless input
                instructions = self.parse_instructions input
                snake = [
                    {x: 0, y: 0},
                    {x: 0, y: 0}
                ]
                visit_set = self.perform_instructions snake, instructions
                visit_set.size
            end
        end
    end
end
