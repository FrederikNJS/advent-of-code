require 'pry'
require 'set'

def read_coordinates
  regex = /^(?<x>\d+), (?<y>\d+)$/
  File.readlines('06/puzzle-input.txt')
      .map(&:strip)
      .map { |line| regex.match(line) }
      .map { |match| [match[:x].to_i, match[:y].to_i] }
end

def calc_bounds(coordinates)
  [
    [coordinates.min_by { |x, _y| x }[0], coordinates.min_by { |_x, y| y }[1]],
    [coordinates.max_by { |x, _y| x }[0], coordinates.max_by { |_x, y| y }[1]]
  ]
end

def map_coord(bounds, coord)
  [
    coord[0] - bounds[0][0] + 1,
    coord[1] - bounds[0][1] + 1
  ]
end

def manhattan_dist(point1, point2)
  (point1[0] - point2[0]).abs + (point1[1] - point2[1]).abs
end

def create_field(bounds)
  Array.new((bounds[1][0] - bounds[0][0]) + 2) do
    Array.new((bounds[1][1] - bounds[0][1]) + 2)
  end
end

def calc_dist_field(field, coordinates, bounds)
  field.map.with_index do |col, x|
    col.map.with_index do |_cell, y|
      distances = coordinates.group_by do |coordinate|
        manhattan_dist([x, y], map_coord(bounds, coordinate))
      end
      shortest_distance = distances.keys.min
      if distances[shortest_distance].size == 1
        distances[shortest_distance][0]
      else
        '.'
      end
    end
  end
end

def find_infinite(dist_field)
  infinite = Set.new
  dist_field[0].each { |nearest| infinite.add nearest }
  dist_field[-1].each { |nearest| infinite.add nearest }
  dist_field.each do |row|
    infinite.add row[0]
    infinite.add row[-1]
  end
  infinite
end

def area_counter(field, ignore)
  areas = {}
  areas.default = 0
  field.each do |row|
    row.each do |cell|
      next if ignore.include? cell
      areas[cell] += 1
    end
  end
  areas
end

def run
  coordinates = read_coordinates
  bounds = calc_bounds coordinates

  field = create_field bounds
  dist_field = calc_dist_field field, coordinates, bounds
  infinite = find_infinite dist_field
  areas = area_counter dist_field, infinite
  puts "Largest area is #{areas.values.max}"
end

run
