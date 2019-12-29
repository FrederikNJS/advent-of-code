require_relative '../11/part1.rb'
require 'logger'
require 'pry'

module Day201915
    Location = Struct.new(:x, :y)

    def Day201915.bfs(neighbors, start, finish=nil)
        queue = [start]
        discovered = Set[start]
        paths = {}
        until queue.empty?
            v = queue.shift
            if !finish.nil? && v == finish
                path = [v]
                current_vertex = v
                while paths.has_key? current_vertex
                    next_step = paths[current_vertex]
                    path << next_step
                    current_vertex = next_step
                end
                return path
            end
            neighbors[v].each do |neighbor|
                unless discovered.include? neighbor
                    discovered << neighbor
                    paths[neighbor] = v
                    queue << neighbor
                end
            end
        end
        paths
    end

    def Day201915.detect_unknowns(world)

    end

    def Day201915.get_neighbors(location)
        [
            Location.new(location.x, location.y - 1),
            Location.new(location.x, location.y + 1),
            Location.new(location.x - 1, location.y),
            Location.new(location.x + 1, location.y)
        ]
    end

    def Day201915.get_unknown_neighbor(current_location, world)
        neighbors = get_neighbors(current_location)
        realized_neighbors = neighbors.map { |location| world[location] }

        directions = realized_neighbors.map.with_index { |value, index| value.nil? ? index + 1 : nil}
        directions.filter { |value| !value.nil? }
    end

    def Day201915.try_direction(direction, input, output, current_location, world)
        input << direction
        result = output.pop
        target = nil
        case direction
        when 1
            target = Location.new(current_location.x, current_location.y - 1)
        when 2
            target = Location.new(current_location.x, current_location.y + 1)
        when 3
            target = Location.new(current_location.x - 1, current_location.y)
        when 4
            target = Location.new(current_location.x + 1, current_location.y)
        end
        world[target] = result
        return result == 0 ? current_location : target
    end

    def Day201915.pretty_print(world, current_location, path=nil)
        x_min, x_max = world.keys.map { |location| location.x }.minmax
        y_min, y_max = world.keys.map { |location| location.y }.minmax
        ary = Array.new(y_max - y_min + 1) do |index|
            Array.new(x_max - x_min + 1) do |index2|
                '░░'
            end
        end
        world.each_pair do |location, value|
            value_map = {
                0 => '██',
                1 => '  ',
                2 => '><'
            }

            ary[location.y - y_min][location.x - x_min] = (!path.nil? && path.include?(location)) ? "▒▒" : value_map[value]
        end
        ary[current_location.y - y_min][current_location.x - x_min] = '⬤ '
        puts ""
        ary.each.with_index do |row, y|
            puts row.join
        end
        puts ""
    end

    def Day201915.build_path(paths, v)
        path = []
        current_vertex = v
        while paths.has_key? current_vertex
            next_step = paths[current_vertex]
            if current_vertex.x < next_step.x
                path << 3
            elsif current_vertex.x > next_step.x
                path << 4
            elsif current_vertex.y < next_step.y
                path << 1
            elsif current_vertex.y > next_step.y
                path << 2
            end
            current_vertex = next_step
        end
        return path
    end

    def Day201915.build_neighbor_map(world, potential_unknowns)
        temp_world = world.clone
        potential_unknowns.each { |potential_unknown| temp_world[potential_unknown] = nil }

        temp_world.map do |location, value|
            neighbors = get_neighbors(location).filter do |location|
                (world.has_key?(location) && world[location] != 0) || potential_unknowns.include?(location)
            end
            [location, neighbors]
        end.to_h
    end

    def Day201915.explore_everything(input, output)
        world = Hash.new
        current_location = Location.new(0, 0)
        world[current_location] = 1

        loop do
            loop do
                unknown_neighbors = get_unknown_neighbor(current_location, world)
                if unknown_neighbors.empty?
                    break
                end
                current_location = try_direction(unknown_neighbors[0], input, output, current_location, world)
                #pretty_print world, current_location
            end

            potential_unknowns = world.map do |location, value|
                neighbors = get_neighbors(location)
                realized_neighbors = neighbors.map { |location| [location, world[location]] }.to_h
                realized_neighbors.filter { |location, value| value.nil? }.keys.to_set
            end.reduce { |a, b| a + b }

            if potential_unknowns.empty?
                break
            end

            neighbor_map = build_neighbor_map(world, potential_unknowns)
            paths = bfs(neighbor_map, current_location)

            instructions = potential_unknowns.map do |potential_unknown|
                [potential_unknown, build_path(paths, potential_unknown).reverse]
            end.to_h.filter do |target, instruction|
                !instruction.empty?
            end

            if instructions.empty?
                break
            end

            shortest_instruction = instructions.min_by { |target, instruction| instruction.length }
            shortest_instruction[1].each do |instruction|
                current_location = try_direction(instruction, input, output, current_location, world)
                #pretty_print world, current_location
            end
        end
        world
    end

    if __FILE__ == $0
        input = File.read('2019/15/puzzle-input.txt')
        program = input.chomp.split(',').map { |string_ops| string_ops.to_i }

        inputs = Queue.new
        outputs = Queue.new

        thread = Thread.new {
            process_program111(program, inputs, outputs)
        }

        final_world = explore_everything(inputs, outputs)
        pretty_print final_world, Location.new(0, 0)

        target = final_world.find do |location, value|
            value == 2
        end[0]
        neighbors = build_neighbor_map(final_world, Set.new)
        paths = bfs(neighbors, Location.new(0, 0))
        path = build_path(paths, target)

        puts "Part 1: #{path.length}"

        oxygen_paths = bfs(neighbors, target)
        all_paths = final_world.filter do |location, value|
            value == 1
        end.map do |location, value|
            build_path(oxygen_paths, location)
        end

        longest_path = all_paths.max_by do |path|
            path.length
        end

        puts "Part 2: #{longest_path.length}"
    end
end
