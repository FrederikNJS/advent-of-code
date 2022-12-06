require 'pry'
require 'set'

module Y2022
    module Day6
        module Part1
            def self.read_input
                File.read('2022/06/puzzle-input.txt').chomp
            end

            def self.find_first_marker input, window_size=4
                ((window_size-1)...input.length).each do |index|
                    return index+1 if input[(index-(window_size-1))..index].chars.to_set.size == window_size
                end
                nil
            end

            def self.solve input=nil
                input = self.read_input unless input
                self.find_first_marker input
            end
        end
    end
end
