module Y2021
    module Day6
        module Part2
            def self.convert_to_age_groups fishes
                age_groups = Hash.new(0)
                fishes.each do |fish|
                    age_groups[fish] += 1
                end
                age_groups
            end

            def self.progress_a_day_on_age_groups age_groups
                new_age_groups = Hash.new(0)
                age_groups.each do |age, count|
                    if age == 0
                        new_age_groups[6] += count
                        new_age_groups[8] += count
                    else
                        new_age_groups[age - 1] += count
                    end
                end
                new_age_groups
            end
        end
    end
end
