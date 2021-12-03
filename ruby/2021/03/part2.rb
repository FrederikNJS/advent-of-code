require 'pry'
require_relative './part1.rb'

module Y2021
    module Day3
        module Part2
            part1 = Y2021::Day3::Part1

            def self.find_oxygen_generator_rating values, digits
                working_set = values.dup
                current_digit = digits - 1
                while working_set.count > 1
                    gamma_rate, epsilon_rate = Y2021::Day3::Part1.calculate_diagnostics working_set, digits
                    #binding.pry
                    working_set = working_set.filter do |value|
                        value & (1 << current_digit) == gamma_rate & (1 << current_digit)
                    end
                    current_digit -= 1
                end
                working_set[0]
            end

            def self.find_co2_scrubber_rating values, digits
                working_set = values.dup
                current_digit = digits - 1
                while working_set.count > 1
                    gamma_rate, epsilon_rate = Y2021::Day3::Part1.calculate_diagnostics working_set, digits
                    #binding.pry
                    working_set = working_set.filter do |value|
                        value & (1 << current_digit) == epsilon_rate & (1 << current_digit)
                    end
                    current_digit -= 1
                end
                working_set[0]
            end
        end
    end
end