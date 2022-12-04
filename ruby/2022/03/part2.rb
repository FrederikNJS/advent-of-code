require_relative 'part1.rb'

module Y2022
    module Day3
        module Part2
            @part1 = Y2022::Day3::Part1

            def self.parse_rucksack rucksack
                rucksack.chars.to_set
            end

            def self.parse_input lines
                lines.map {|line| self.parse_rucksack line}
            end

            def self.group_elves rucksacks
                rucksacks.each_slice 3
            end

            def self.solve input=nil
                input = @part1.read_input unless input
                parsed = self.parse_input input
                groups = self.group_elves parsed
                commonalities = groups.map {|group| @part1.find_commonalities(group)}
                priorities = commonalities.map {|commonality| @part1.calculate_priority(commonality)}
                priorities.sum
            end
        end
    end
end
