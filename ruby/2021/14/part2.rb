module Y2021
    module Day14
        module Part2
            def self.counts template
                character_counts = template.chars.group_by{|c| c}.map{|c, l| [c, l.size]}.to_h
                character_counts.default = 0
                pair_counts = Hash.new(0)
                for x in (0...(template.size-1))
                    pair_counts[template[x..x+1]] += 1
                end
                [character_counts, pair_counts]
            end

            def self.polymer_count_step character_counts, pair_counts, rules
                new_character_counts = character_counts.dup
                new_pair_counts = pair_counts.dup
                rules.each do |pair, subst|
                    pair_count = pair_counts[pair]
                    new_pair_counts[pair] -= pair_count
                    new_pair_counts[pair[0] + subst] += pair_count
                    new_pair_counts[subst + pair[1]] += pair_count
                    new_character_counts[subst] += pair_count
                end
                [new_character_counts, new_pair_counts]
            end

            def self.polymer_counter steps, character_counts, pair_counts, rules
                steps.times do
                    character_counts, pair_counts = self.polymer_count_step character_counts, pair_counts, rules
                end
                [character_counts, pair_counts]
            end

            def self.polymer_tension character_counts
                min, max = character_counts.minmax_by {|c, n| n}
                max[1] - min[1]
            end
        end
    end
end
