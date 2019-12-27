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

$best_distance = 1_000_000

def all_shortest_path(targets, shortest_paths, paths_blocked_by, origin, found_keys=Immutable::Set['@'], distance=0)
    puts found_keys.inspect

    if (targets.keys - found_keys).empty?
        $best_distance = distance if $best_distance > distance
        puts "Found new best: #{distance}"
        #binding.pry
        return distance
    end


    #binding.pry
    (targets.keys - found_keys).filter do |target|
        (paths_blocked_by[origin][target] - found_keys.map(&:upcase)).empty?
    end.sort_by do |target|
        shortest_paths[origin][target].length
    end.map do |target|
        choice_length = distance + shortest_paths[target].length - 1
        result = nil
        if choice_length < $best_distance
            puts "#{choice_length} vs #{$best_distance}"
            result = all_shortest_path(targets, shortest_paths, paths_blocked_by, target, found_keys.add(target), choice_length)
        end
        result
    end.filter do |result|
        !result.nil?
    end.min
end

def possible_keys(paths, special_locations)
    special_locations.filter do |name, location|
        ('a'..'z').include?(name) && paths.keys.include?(location)
    end.keys
end

CacheKey = Struct.new(:current_key, :keys_to_find)
def distance_to_collect_keys(current_key, keys_to_find, cache, input, special_locations, all_keys)
    if keys_to_find.empty?
        return 0
    end
    cacheKey = CacheKey.new(current_key, keys_to_find)
    if cache.include? cacheKey
        return cache[cacheKey]
    end

    result = 1_000_000
    puts keys_to_find


    neighbors = generate_neighbor_hash(input, current_key, all_keys - keys_to_find)
    paths = bfs(neighbors, special_locations[current_key], finish=nil)
    reachable = possible_keys(paths, special_locations)
    reachable.to_set.intersection(keys_to_find).each do |key, location|
        d = (build_path(paths, special_locations[key]).length - 1) + distance_to_collect_keys(key, keys_to_find - Set[key], cache, input, special_locations, all_keys)
        result = [result, d].min
    end

    cache[cacheKey] = result
    puts result
    return result
end

if __FILE__ == $0
    input = File.readlines('2019/18/puzzle-input.txt')
        .map {|line| line.chomp.chars.to_list}.to_list

    special_locations = find_special_locations input

    targets = special_locations.filter do |location|
        ('a'..'z').include? location
    end

    cache = Hash.new

    result = distance_to_collect_keys('@', targets.keys.to_set, cache, input, special_locations, targets.keys.to_set)

    puts "debug"

    #wat = recurse_key_search(input, special_locations)

    #height = input.length
    #width = input[0].length
end
