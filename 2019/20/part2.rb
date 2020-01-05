require 'pry'
require 'ruby-progressbar'

XYCoord = Struct.new(:x, :y, :level)
XYZCoord = Struct.new(:x, :y, :level)

module Day201920
    def Day201920.is_on_outer_rim(coord)
        coord.x == 2 || coord.y == 2 || coord.x == 120 || coord.y == 122
    end

    def Day201920.is_on_inner_rim(coord)
        ((coord.x == 32 || coord.x == 90) && (32..92).include?(coord.y)) || ((coord.y == 32 || coord.y == 92) && (32..90).include?(coord.x))
    end

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
            neighbors[XYCoord.new(v.x, v.y)].each do |raw_neighbor|
                level = nil
                if is_on_outer_rim(v) && is_on_inner_rim(raw_neighbor)
                    level = v.level - 1
                elsif is_on_inner_rim(v) && is_on_outer_rim(raw_neighbor)
                    level = v.level + 1
                else
                    level = v.level
                end
                next if level < 0
                neighbor = XYZCoord.new(raw_neighbor.x, raw_neighbor.y, level)

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
                        neighbors[XYCoord.new(x, y)] << XYCoord.new(x, y + 1)
                        neighbors[XYCoord.new(x, y + 1)] << XYCoord.new(x, y)
                    end
                    if world[y][x + 1] == '.'
                        neighbors[XYCoord.new(x, y)] << XYCoord.new(x + 1, y)
                        neighbors[XYCoord.new(x + 1, y)] << XYCoord.new(x, y)
                    end
                    if ('A'..'Z').include? world[y][x - 1]
                        name = get_portal_name(world, x - 1, y)
                        if portals.key? name
                            neighbors[XYCoord.new(x, y)] << portals[name]
                            neighbors[portals[name]] << XYCoord.new(x, y)
                        else
                            portals[name] = XYCoord.new(x, y)
                        end
                    end
                    if ('A'..'Z').include? world[y][x + 1]
                        name = get_portal_name(world, x + 1, y)
                        if portals.key? name
                            neighbors[XYCoord.new(x, y)] << portals[name]
                            neighbors[portals[name]] << XYCoord.new(x, y)
                        else
                            portals[name] = XYCoord.new(x, y)
                        end
                    end
                    if ('A'..'Z').include? world[y - 1][x]
                        name = get_portal_name(world, x, y - 1)
                        if portals.key? name
                            neighbors[XYCoord.new(x, y)] << portals[name]
                            neighbors[portals[name]] << XYCoord.new(x, y)
                        else
                            portals[name] = XYCoord.new(x, y)
                        end
                    end
                    if ('A'..'Z').include? world[y + 1][x]
                        name = get_portal_name(world, x, y + 1)
                        if portals.key? name
                            neighbors[XYCoord.new(x, y)] << portals[name]
                            neighbors[portals[name]] << XYCoord.new(x, y)
                        else
                            portals[name] = XYCoord.new(x, y)
                        end
                    end
                end
            end
        end
        neighbors
    end

    if __FILE__ == $0
        input = File.readlines('2019/20/puzzle-input.txt').map { |line| line.chomp.chars }
        puts "width: #{input.map{|row| row.length}.max}"
        puts "height: #{input.length}"
        neighbors = build_neighbors(input)
        from = XYZCoord.new(2, 61, 0)
        to = XYZCoord.new(2, 85, 0)

        path = bfs(neighbors, from, to)
        puts (path.length - 1)
    end
end

#5178 too low
