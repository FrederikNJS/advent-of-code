module Y2021
    module Day7
        module Part1
            def self.read_input
                File.read('2021/07/puzzle-input.txt').chomp
            end

            def self.parse_input raw
                raw.split(',').map(&:to_i)
            end

            def self.calculate_fuel_cost crab_positions, position
                crab_positions.map { |crab_pos| (crab_pos - position).abs }
            end

            def self.calculate_all_fuel_costs crab_positions
                min, max = crab_positions.minmax
                fuel_costs = (min..max).map {|position| [position, self.calculate_fuel_cost(crab_positions, position).sum]}.to_h
            end

            def self.find_best_position crab_positions
                fuel_costs = self.calculate_all_fuel_costs crab_positions
                fuel_costs.min_by { |position, fuel_cost| fuel_cost }
            end
        end
    end
end
