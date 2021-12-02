module Y2021
    module Day2
        module Part2
            def self.calculate_depth_and_distance input
                depth = 0
                distance = 0
                aim = 0
                input.each do |direction, count|
                    case direction
                    when 'forward'
                        distance += count
                        depth += aim * count
                    when 'down'
                        aim += count
                    when 'up'
                        aim -= count
                    end
                end
                [distance, depth]
            end
        end
    end
end