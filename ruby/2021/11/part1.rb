10
10
10
10
require 'pry'

module Y2021
    module Day11
        module Part1
            def self.read_input
                File.readlines('2021/11/puzzle-input.txt').map(&:chomp)
            end

            def self.parse_input raw
                raw.map {|line| line.chars.map{|char| char.to_i}}
            end
        end
    end
end
