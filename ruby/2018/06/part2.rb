require 'pry'
require 'set'

def read_coordinates
  regex = /^(?<x>\d+), (?<y>\d+)$/
  File.readlines('2018/06/puzzle-input.txt')
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
  Array.new((bounds[1][0] - bounds[0][0])) do
    Array.new((bounds[1][1] - bounds[0][1]))
  end
end

def calc_sweetspot(field, coordinates, bounds)
  field.map.with_index do |col, x|
    col.map.with_index do |_cell, y|
      distances = coordinates.map do |coordinate|
        manhattan_dist([x, y], map_coord(bounds, coordinate))
      end
      distances.sum < 10_000
    end
  end
end

def sweetspot_counter(sweetspot_field)
  sweetspot_field.sum do |row|
    row.count do |cell|
      cell
    end
  end
end

def run
  coordinates = read_coordinates
  bounds = calc_bounds coordinates

  field = create_field bounds
  sweetspot_field = calc_sweetspot field, coordinates, bounds
  sweetspot_count = sweetspot_counter sweetspot_field
  puts "The sweetspot is #{sweetspot_count} cells"
end

run
