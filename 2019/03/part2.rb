require_relative 'part1.rb'

#class Graph
#    def initialize()
#        @edges = Hash.new { |hash, key| hash[key] = Set.new }
#    end
#
#    def add_edge(a, b)
#        @edges[a] << b
#        @edges[b] << a
#    end
#
#    def get_neighbors(a)
#        @edges[a]
#    end
#end
#
#def merge_paths(path_a, path_b)
#    path_a.to_set.union path_b.to_set
#end
#
#def build_graph(lines)
#    graph = Graph.new()
#
#    lines.each do |line|
#        position = {x: 0, y: 0}
#
#        line.each do |instruction|
#            instruction[:length].times do
#                old = position.clone
#                case instruction[:direction]
#                when 'U'
#                    position[:y] += 1
#                when 'D'
#                    position[:y] -= 1
#                when 'R'
#                    position[:x] += 1
#                when 'L'
#                    position[:x] -= 1
#                end
#                graph.add_edge(old, position.clone) unless old[:x] == 0 and old[:y] == 0
#            end
#        end
#    end
#    return graph
#end
#
#def bfs(graph, start, finish)
#    queue = []
#    discovered = Set[start]
#    paths = {}
#    queue << start
#    until queue.empty?
#        v = queue.shift
#        if v == finish
#            path = [v]
#            current_vertex = v
#            while paths.has_key? current_vertex
#                next_step = paths[current_vertex]
#                path << next_step
#                current_vertex = next_step
#            end
#            return path
#        end
#        graph.get_neighbors(v).each do |neighbor|
#            unless discovered.include? neighbor
#                discovered << neighbor
#                paths[neighbor] = v
#                queue << neighbor
#            end
#        end
#    end
#end

if __FILE__ == $0
    strings = File.readlines('2019/03/puzzle-input.txt')
    split_a = strings[0].split ','
    split_b = strings[1].split ','

    parsed_instructions_a = split_a.map { |chunks| parse_instruction(chunks) }
    parsed_instructions_b = split_b.map { |chunks| parse_instruction(chunks) }

    path_a = build_path parsed_instructions_a
    path_b = build_path parsed_instructions_b
    intersections = find_intersections path_a, path_b

    total_distance = Float::INFINITY
    intersections.each do |intersection|
        a_distance = path_a.index intersection
        b_distance = path_b.index intersection
        if a_distance + b_distance < total_distance
            total_distance = a_distance + b_distance
        end
    end
    puts total_distance + 2
end
