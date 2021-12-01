module Y2019
    module Day1
        module Part2
            sum = 0
            lines = File.readlines('2019/01/puzzle-input.txt').map(&:strip)
            def self.fuel_calc2(weight)
                fuel_part = (weight / 3).floor - 2
                if fuel_part <= 0
                    return 0
                else
                    return fuel_part + fuel_calc2(fuel_part)
                end
            end

            if __FILE__ == $0
                weights = lines.map { |line| line.to_i }
                fuels = weights.map { |weight| fuel_calc2 weight }
                puts fuels.reduce 0, :+
            end
        end
    end
end