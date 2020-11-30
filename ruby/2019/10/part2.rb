require 'pry'
require_relative 'part1.rb'

def dot_product_e a, b
    a.x * b.x + a.y * b.y
end

def asteroid_angle(origin, asteroid)
    n = 90 - (Math.atan2(origin.y - asteroid.y, (-origin.x) - (-asteroid.x))) * 180 / Math::PI;
    return n % 360;
end

if __FILE__ == $0 # || true
    asteroid_map = File.readlines('2019/10/puzzle-input.txt').map(&:chomp)

    asteroids = get_asteroids asteroid_map
    origin_asteroid = Asteroid.new(30, 34)
    visible_asteroid_count = 344

    visible_asteroids = find_visible_asteroids(origin_asteroid, asteroids)
    angles = visible_asteroids.map do |asteroid|
        [asteroid_angle(origin_asteroid, asteroid), asteroid]
    end

    sorted = angles.sort do |a, b|
        a[0] <=> b[0]
    end

    puts sorted[199]
end
