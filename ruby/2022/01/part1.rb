module Y2022
    module Day1
        module Part1
            def self.read_input
                File.readlines('2022/01/puzzle-input.txt').map(&:chomp).map(&:to_i)
            end

            def self.split_elves values
                values.chunk_while{|el, next_el| el != 0}.to_a
            end

            def self.sum_elves chunks
                chunks.map { |chunk| chunk.sum }
            end
        end
    end
end
