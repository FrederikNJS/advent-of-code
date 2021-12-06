module Y2021
    module Day6
        module Part1
            def self.read_input
                File.read('2021/06/puzzle-input.txt').chomp
            end

            def self.parse_input raw
                raw.split(",").map { |item| item.to_i }
            end

            def self.progress_a_day fishes
                new_fish = []
                updated_fish = fishes.map do |fish|
                    if fish == 0
                        new_fish << 8
                        6
                    else
                        fish - 1
                    end
                end
                updated_fish.concat new_fish
            end
        end
    end
end
