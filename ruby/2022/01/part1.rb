module Y2022
    module Day1
        module Part1
            def self.read_input
                File.readlines('2022/01/puzzle-input.txt').map(&:chomp)
            end

            def self.parse_input input
                input.map(&:to_i)
            end

            def self.split_elves values
                values.chunk_while{|el, next_el| el != 0}.to_a
            end

            def self.sum_elves chunks
                chunks.map { |chunk| chunk.sum }
            end

            def self.solve input=nil
                input = self.read_input unless input
                parsed = self.parse_input input
                chunks = self.split_elves parsed
                sums = self.sum_elves chunks
                sums.max
            end
        end
    end
end
