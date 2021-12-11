require 'pry'

module Y2021
    module Day9
        module Part1
            def self.read_input
                File.readlines('2021/09/puzzle-input.txt').map(&:chomp)
            end

            def self.parse_input raw
                input = Hash.new(9)
                raw.each_with_index { |line,row| line.chars.each_with_index { |char,column| input[[row, column]] = char.to_i }}
                input
            end

            def self.find_low_points input
                input.filter do |coord, value|
                    row, column = coord
                    input[[row-1, column]] > value && input[[row+1, column]] > value && input[[row, column-1]] > value && input[[row, column+1]] > value
                end
            end

            def self.calculate_risk_level low_points
                low_points.sum { |coord, value| value + 1 }
            end
        end
    end
end
