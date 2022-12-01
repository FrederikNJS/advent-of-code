module Y2022
    module Day1
        module Part2
            def self.detect_window_increases values
                increases = 0
                for i in 3...values.length
                    increases += 1 if values[i-3] + values[i-2] + values[i-1] < values[i-2] + values[i-1] + values[i]
                end
                increases
            end
        end
    end
end
