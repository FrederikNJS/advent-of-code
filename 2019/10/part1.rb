Asteroid = Struct.new(:x, :y)

def get_asteroids(asteroid_map)
    coordinates = Set.new
    asteroid_map.each.with_index do |row, row_index|
        row.chars.each.with_index do |x, col_index|
            coordinates << Asteroid.new(col_index, row_index) if x == '#'
        end
    end
    coordinates
end

def point_distance_from_line(p1, p2, p0)
    p1x = p1.x
    p1y = p1.y
    p2x = p2.x
    p2y = p2.y
    Rational(
        ((p2y - p1y) * p0.x - (p2x - p1x) * p0.y + p2x * p1y - p2y * p1x).abs,
        Math.sqrt((p2y - p1y).pow(2) + (p2x - p1x).pow(2))
    )
end

def manhattan_distance(a, b)
    (a.x - b.x).abs + (a.y - b.y).abs
end

def asteroid_visible?(origin, target, asteroids)
    other_asteroids = (asteroids - Set[origin, target])
    asteroids_on_line = other_asteroids.filter do |asteroid|
        point_distance_from_line(origin, target, asteroid) == 0
    end

    valid_x_asteroids = nil
    if origin.x < target.x
        valid_x_asteroids = asteroids_on_line.filter { |asteroid| origin.x < asteroid.x }
    else
        valid_x_asteroids = asteroids_on_line.filter { |asteroid| origin.x >= asteroid.x }
    end

    if origin.y < target.y
        valid_x_and_y_asteroids = valid_x_asteroids.filter { |asteroid| origin.y < asteroid.y }
    else
        valid_x_and_y_asteroids = valid_x_asteroids.filter { |asteroid| origin.y >= asteroid.y }
    end

    target_distance = manhattan_distance(origin, target)

    valid_x_and_y_asteroids.all? do |asteroid|
        target_distance < manhattan_distance(origin, asteroid)
    end
end

def find_visible_asteroids(origin, asteroids)
    other_asteroids = asteroids - Set[origin]
    other_asteroids.filter do |asteroid|
        asteroid_visible?(origin, asteroid, other_asteroids)
    end
end

def find_all_visibles(asteroids)
    puts "Finding visible asteroids"
    asteroids.map do |asteroid|
        puts "calculating asteroid #{asteroid}"
        visible = [asteroid, find_visible_asteroids(asteroid, asteroids).length]
        visible
    end
end

def find_best_candidate(visible_list)
    puts "Selecting the best candidate"
    visible_list.max { |a, b| a[1] <=> b[1] }
end

if __FILE__ == $0 # || true
    asteroid_map = File.readlines('2019/10/puzzle-input.txt').map(&:chomp)

    puts "Building map"
    asteroids = get_asteroids asteroid_map
    puts "Found #{asteroids.length} asteroids"
    candidates = find_all_visibles asteroids
    best_location = find_best_candidate(candidates)

    puts best_location.inspect

    puts find_visible_asteroids(best_location[0], asteroids)
    puts "wtf"
end
