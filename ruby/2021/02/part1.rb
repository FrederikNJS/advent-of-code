module Y2021
    module Day2
        module Part1
            def self.read_input
                File.readlines('2021/02/puzzle-input.txt').map(&:chomp)
            end

            def self.parse_input raw_input
                raw_input.map(&:split).map { |direction, count| [direction, count.to_i] }
            end

            def self.count_depth_and_distance input
                depth = 0
                distance = 0
                input.each do |direction, count|
                    case direction
                    when 'forward'
                        distance += count
                    when 'down'
                        depth += count
                    when 'up'
                        depth -= count
                    end
                end
                [distance, depth]
            end
        end
    end
end