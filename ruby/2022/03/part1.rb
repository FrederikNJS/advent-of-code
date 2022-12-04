require 'pry'

module Y2022
    module Day3
        module Part1
            def self.read_input
                File.readlines('2022/03/puzzle-input.txt').map(&:chomp)
            end

            def self.parse_rucksack rucksack
                [rucksack[...(rucksack.size / 2)].chars.to_set, rucksack[(rucksack.size / 2)...].chars.to_set]
            end

            def self.parse_input lines
                lines.map {|line| self.parse_rucksack line}
            end

            def self.find_commonalities sets
                sets.reduce(sets.first, :intersection)
            end

            def self.calculate_priority commonalities
                item = commonalities.to_a[0]
                case item
                when /[[:upper:]]/ then return item.ord - 'A'.ord + 27
                when /[[:lower:]]/ then return item.ord - 'a'.ord + 1
                end
            end

            def self.solve input=nil
                input = self.read_input unless input
                parsed = self.parse_input input
                commonalities = parsed.map {|rucksack| self.find_commonalities(rucksack)}
                priorities = commonalities.map {|commonality| self.calculate_priority(commonality)}
                priorities.sum
            end
        end
    end
end
