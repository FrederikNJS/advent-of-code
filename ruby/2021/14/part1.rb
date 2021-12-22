require 'immutable'
require 'pry'

module Y2021
    module Day14
        module Part1
            def self.read_input
                File.read('2021/14/puzzle-input.txt').chomp
            end

            def self.parse_input raw
                initial_template, raw_rules = raw.split("\n\n")
                rules = raw_rules.lines.map{|line| line.chomp.split(" -> ")}.to_h
                [initial_template, rules]
            end

            def self.polymer_step template, rules
                new_template = []
                for x in (0...(template.size-1))
                    new_template << template[x]
                    new_template << rules["#{template[x]}#{template[x+1]}"]
                end
                new_template << template[template.size-1]
                new_template
            end

            def self.simulate_n_polymer_steps steps, template, rules
                steps.times do
                    template = self.polymer_step template, rules
                end
                template
            end

            def self.polymer_tension template
                min, max = template.group_by {|c| c}.map{|c, list_c| [c, list_c.size]}.minmax_by{|c, count| count}
                max[1] - min[1]
            end
        end
    end
end
