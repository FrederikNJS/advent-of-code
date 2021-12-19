module Y2021
    module Day12
        module Part2
            def self.find_all_paths path_map, source, target
                queue = Queue.new
                queue << Immutable::List[source]
                paths = Set.new
                until queue.empty?
                    current_path = queue.pop
                    last_element = current_path.head
                    path_map[last_element].filter do |element|
                        if element.downcase == element
                            only_lowercase = current_path.filter {|element| element.downcase == element}
                            path_has_duplicate = only_lowercase.group_by{ |e| e }.select { |k, v| v.size > 1 }.size > 0
                            (current_path.count(element) == 1 && !path_has_duplicate) || current_path.count(element) == 0
                        else
                            true
                        end
                    end.each do |element|
                        new_path = current_path.add element
                        if element == target
                            paths << new_path.reverse
                        else
                            queue << new_path
                        end
                    end
                end
                paths
            end
        end
    end
end
