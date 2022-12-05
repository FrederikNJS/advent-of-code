require 'pry'

module Y2022
    module Day4
        module Part1
            def self.read_input
                File.readlines('2022/04/puzzle-input.txt').map(&:chomp)
            end

            def self.parse_line line
                a, b = line.split(',')
                a_start, a_end = a.split('-').map{|n| n.to_i}
                b_start, b_end = b.split('-').map{|n| n.to_i}
                [
                    Range.new(a_start, a_end),
                    Range.new(b_start, b_end)
                ]
            end

            def self.parse_input lines
                lines.map{|line| self.parse_line line}
            end

            def self.completely_contained? a, b
                a.cover?(b) || b.cover?(a)
            end

            def self.solve input=nil
                input = self.read_input unless input
                parsed = self.parse_input input
                completely_contained = parsed.filter{|pair| self.completely_contained?(*pair)}
                completely_contained.size
            end
        end
    end
end
