require 'pry'
require 'ruby-progressbar'
Coord = Struct.new(:x, :y)
module Day201920
    def Day201920.bfs(neighbors, start, finish=nil)
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

    def Day201920.get_portal_name(world, x, y)
        if ('A'..'Z').include? world[y - 1][x]
            return world[y - 1][x] + world[y][x]
        end
        if ('A'..'Z').include? world[y + 1][x]
            return world[y][x] + world[y + 1][x]
        end
        if ('A'..'Z').include? world[y][x - 1]
            return world[y][x - 1] + world[y][x]
        end
        if ('A'..'Z').include? world[y][x + 1]
            return world[y][x] + world[y][x + 1]
        end
    end

    def Day201920.build_neighbors(world)
        neighbors = Hash.new { |hash, key| hash[key] = [] }
        portals = Hash.new

        world.each.with_index do |row, y|
            row.each.with_index do |value, x|
                if value == '.'
                    if world[y + 1][x] == '.'
                        neighbors[Coord.new(x, y)] << Coord.new(x, y + 1)
                        neighbors[Coord.new(x, y + 1)] << Coord.new(x, y)
                    end
                    if world[y][x + 1] == '.'
                        neighbors[Coord.new(x, y)] << Coord.new(x + 1, y)
                        neighbors[Coord.new(x + 1, y)] << Coord.new(x, y)
                    end
                    if ('A'..'Z').include? world[y][x - 1]
                        name = get_portal_name(world, x - 1, y)
                        if portals.key? name
                            neighbors[Coord.new(x, y)] << portals[name]
                            neighbors[portals[name]] << Coord.new(x, y)
                        else
                            portals[name] = Coord.new(x, y)
                        end
                    end
                    if ('A'..'Z').include? world[y][x + 1]
                        name = get_portal_name(world, x + 1, y)
                        if portals.key? name
                            neighbors[Coord.new(x, y)] << portals[name]
                            neighbors[portals[name]] << Coord.new(x, y)
                        else
                            portals[name] = Coord.new(x, y)
                        end
                    end
                    if ('A'..'Z').include? world[y - 1][x]
                        name = get_portal_name(world, x, y - 1)
                        if portals.key? name
                            neighbors[Coord.new(x, y)] << portals[name]
                            neighbors[portals[name]] << Coord.new(x, y)
                        else
                            portals[name] = Coord.new(x, y)
                        end
                    end
                    if ('A'..'Z').include? world[y + 1][x]
                        name = get_portal_name(world, x, y + 1)
                        if portals.key? name
                            neighbors[Coord.new(x, y)] << portals[name]
                            neighbors[portals[name]] << Coord.new(x, y)
                        else
                            portals[name] = Coord.new(x, y)
                        end
                    end
                end
            end
        end
        neighbors
    end

    if __FILE__ == $0
        input = File.readlines('2019/20/puzzle-input.txt').map { |line| line.chomp.chars }
        neighbors = build_neighbors(input)
        from = Coord.new(2, 61)
        to = Coord.new(2, 85)

        path = bfs(neighbors, from, to)
        puts (path.length - 1)
    end
end
