module Y2021
    module Day1
        module Part1
            def self.read_input
                File.readlines('2021/01/puzzle-input.txt').map(&:chomp).map(&:to_i)
            end

            def self.detect_increases values
                counter = 0
                for index in 1...values.length
                    counter += 1 if values[index-1] < values[index]
                end
                counter
            end
        end
    end
end
