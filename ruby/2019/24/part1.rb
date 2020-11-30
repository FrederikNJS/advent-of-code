require 'pry'

module Day201924
    def Day201924.step(world)
        new_world = Array.new(world.length) {
            Array.new(world[0].length) {
                nil
            }
        }
        world.each.with_index do |row, y|
            row.each.with_index do |value, x|
                #binding.pry
                neighbors = [
                    y-1 < 0 ? '.' : world[y-1][x],
                    y+1 == world.length ? '.' : world[y+1][x],
                    x-1 < 0 ? '.' : world[y][x-1],
                    x+1 == world[y].length ? '.' : world[y][x+1],
                ]
                if value == '#'
                    if neighbors.count('#') == 1
                        new_world[y][x] = '#'
                    else
                        new_world[y][x] = '.'
                    end
                else
                    if neighbors.count('#') == 1 || neighbors.count('#') == 2
                        new_world[y][x] = '#'
                    else
                        new_world[y][x] = '.'
                    end
                end
            end
        end
        new_world
    end

    def Day201924.find_first_cycle(world)
        seen = Set.new

        while true
            if seen.include? world
                return world
            end
            seen << world

            world = step(world)
        end
    end

    def Day201924.calculate_biodiversity(world)
        world.join.reverse.gsub('.', '0').gsub('#', '1').to_i(2)
    end

    if __FILE__ == $0
        input = File.readlines('2019/24/puzzle-input.txt').map(&:chomp).map(&:chars)
        cycle = find_first_cycle(input)
        biodiversity = calculate_biodiversity(cycle)
        puts biodiversity
    end
end
