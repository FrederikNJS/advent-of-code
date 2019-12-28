require 'pry'
require 'immutable'

Coord = Struct.new(:x, :y)
Location = Struct.new(:x, :y, :value)

def bfs(neighbors, start, finish=nil)
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

def find_special_locations(input)
    special_locations = {}

    input.each.with_index do |row, y|
        row.each.with_index do |value, x|
            unless Set["#", "."].include? value
                special_locations[value] = Coord.new(x, y)
            end
        end
    end
    special_locations
end

def generate_neighbor_hash(input, origin, known_keys=Set[])
    neighbors = Hash.new {|hash,key| hash[key] = Array.new }
    open_doors = known_keys.map(&:capitalize).to_set

    input.each.with_index do |row, y|
        row.each.with_index do |value, x|
            if Set['.', '@'].include?(value) || known_keys.include?(value) || open_doors.include?(value)
                if Set['.', '@'].include?(input[y][x - 1]) || ('a'..'z').include?(input[y][x - 1]) || open_doors.include?(input[y][x - 1])
                    neighbors[Coord.new(x, y)] << Coord.new(x - 1, y)
                end
                if Set['.', '@'].include?(input[y][x + 1]) || ('a'..'z').include?(input[y][x + 1]) || open_doors.include?(input[y][x + 1])
                    neighbors[Coord.new(x, y)] << Coord.new(x + 1, y)
                end
                if Set['.', '@'].include?(input[y - 1][x]) || ('a'..'z').include?(input[y - 1][x]) || open_doors.include?(input[y - 1][x])
                    neighbors[Coord.new(x, y)] << Coord.new(x, y - 1)
                end
                if Set['.', '@'].include?(input[y + 1][x]) || ('a'..'z').include?(input[y + 1][x]) || open_doors.include?(input[y + 1][x])
                    neighbors[Coord.new(x, y)] << Coord.new(x, y + 1)
                end
            end
        end
    end
    neighbors
end

def build_path(paths, v)
    path = [v]
    current_vertex = v
    while paths.has_key? current_vertex
        next_step = paths[current_vertex]
        path << next_step
        current_vertex = next_step
    end
    return path
end

def possible_keys(paths, special_locations)
    special_locations.filter do |name, location|
        ('a'..'z').include?(name) && paths.keys.include?(location)
    end.keys
end

def pretty_print_state(input, paths)
    input.each.with_index do |row, y|
        new_row = row.map.with_index do |value, x|
            paths.keys.include?(Coord.new(x, y)) ? "+" : value
        end.join
        puts new_row
    end
end

$best_result = 1_000_000

CacheKey = Struct.new(:robots, :keys_to_find)
def distance_to_collect_keys(robots, keys_to_find, cache, input, special_locations, all_keys)
    if keys_to_find.empty?
        return 0
    end
    cacheKey = CacheKey.new(robots, keys_to_find)
    if cache.include? cacheKey
        return cache[cacheKey]
    end

    result = 1_000_000
    puts keys_to_find

    robots.each.with_index do |robot, index|
        neighbors = generate_neighbor_hash(input, robot, all_keys - keys_to_find)
        paths = bfs(neighbors, robot, finish=nil)
        reachable = possible_keys(paths, special_locations)
        reachable.to_set.intersection(keys_to_find).each do |key|
            d = (build_path(paths, special_locations[key]).length - 1) + distance_to_collect_keys(robots.set(index, special_locations[key]), keys_to_find - Set[key], cache, input, special_locations, all_keys)
            result = [result, d].min
        end
    end

    cache[cacheKey] = result
    return result
end

if __FILE__ == $0
    input = File.readlines('2019/18/puzzle-input2.txt')
        .map {|line| line.chomp.chars.to_list}
        .to_list

    special_locations = find_special_locations input

    targets = special_locations.filter do |location|
        ('a'..'z').include? location
    end

    cache = Hash.new

    robots = Immutable::Vector[
        Coord.new(39, 39),
        Coord.new(39, 41),
        Coord.new(41, 39),
        Coord.new(41, 41)
    ]
    result = distance_to_collect_keys(robots, targets.keys.to_set, cache, input, special_locations, targets.keys.to_set)
    puts result
end
