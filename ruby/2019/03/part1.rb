require 'pry'

module Y2019
    module Day3
        module Part1
            def self.parse_instruction(instruction)
                return {direction: instruction[0], length: instruction.slice(1..-1).to_i}
            end

            def self.build_path(line)
                path = []
                position_x = 0
                position_y = 0
                line.each do |instruction|

                    case instruction[:direction]
                    when 'U'
                        instruction[:length].times do
                            position_y += 1
                            path.append({x: position_x, y: position_y})
                        end
                    when 'D'
                        instruction[:length].times do
                            position_y -= 1
                            path.append({x: position_x, y: position_y})
                        end
                    when 'R'
                        instruction[:length].times do
                            position_x += 1
                            path.append({x: position_x, y: position_y})
                        end
                    when 'L'
                        instruction[:length].times do
                            position_x -= 1
                            path.append({x: position_x, y: position_y})
                        end
                    end
                end
                return path
            end

            def self.find_intersections(line_a, line_b)
                set_a = line_a.to_set
                set_b = line_b.to_set
                return set_a.intersection set_b
            end

            def self.intersection_distance(intersection)
                return intersection[:x].abs + intersection[:y].abs
            end

            def self.closest_intersection(intersections)
                intersections_list = intersections.to_a
                distances = intersections_list.map { |intersection| intersection_distance intersection}
                intersections_list[distances.index(distances.min)]
            end

            def self.harness(list_a, list_b)
                instructions_a = list_a.map { |item| parse_instruction item}
                instructions_b = list_b.map { |item| parse_instruction item}
                path_a = build_path instructions_a
                path_b = build_path instructions_b
                intersections = find_intersections path_a, path_b
                closest_intersection = closest_intersection(intersections)
                closest_distance = intersection_distance(closest_intersection)
                return closest_distance
            end

            if __FILE__ == $0
                strings = File.readlines('2019/03/puzzle-input.txt')
                split_a = strings[0].split ','
                split_b = strings[1].split ','

                result = harness(split_a, split_b)
                puts result
            end
        end
    end
end