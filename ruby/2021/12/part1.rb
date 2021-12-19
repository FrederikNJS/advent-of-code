require 'immutable'
require 'pry'

module Y2021
    module Day12
        module Part1
            def self.read_input
                File.readlines('2021/12/puzzle-input.txt').map(&:chomp)
            end

            def self.parse_input raw
                paths = Hash.new {|hash, key| hash[key] = Set.new }
                raw.each do |line|
                    a, b = line.split('-')
                    paths[a] << b unless b == "start" or a == "end"
                    paths[b] << a unless a == "start" or b == "end"
                end
                Immutable::Hash.new(paths.entries)
            end

            def self.find_all_paths path_map, source, target
                queue = Queue.new
                queue << Immutable::List[source]
                paths = Set.new
                until queue.empty?
                    current_path = queue.pop
                    last_element = current_path.head
                    path_map[last_element].filter do |element|
                        !(element.downcase == element && current_path.include?(element))
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
