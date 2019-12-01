require 'pry'

lines = File.readlines('2018/10/puzzle-input.txt').map {|line| line.strip}

regex = /^position=<\s*(?<x_pos>-?\d+),\s*(?<y_pos>-?\d+)> velocity=<\s*(?<x_vel>-?\d+),\s*(?<y_vel>-?\d+)>$/

lights = lines.map do |line|
  regex.match line
end.map do |match|
  {
    x_pos: match[:x_pos].to_i,
    x_vel: match[:x_vel].to_i,
    y_pos: match[:y_pos].to_i,
    y_vel: match[:y_vel].to_i
  }
end

def x_calc(light, time)
  light[:x_pos] + time * light[:x_vel]
end

def y_calc(light, time)
  light[:y_pos] + time * light[:y_vel]
end

def calc_bounds(lights, time)
  {
    x_min: lights.map { |light| x_calc light, time }.min,
    x_max: lights.map { |light| x_calc light, time }.max,
    y_min: lights.map { |light| y_calc light, time }.min,
    y_max: lights.map { |light| y_calc light, time }.max
  }
end

def calc_area(bounds)
  (bounds[:x_max] - bounds[:x_min]) * (bounds[:y_max] - bounds[:y_min])
end

def calc_dimensions(bounds)
  {
    x: bounds[:x_max] - bounds[:x_min],
    y: bounds[:y_max] - bounds[:y_min]
  }
end

time = -1
best_area = Float::INFINITY
loop do
  new_area = calc_area(calc_bounds(lights, time + 1))
  if new_area < best_area
    best_area = new_area
    time += 1
  else
    break
  end
end

puts time
