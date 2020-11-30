require 'pry'

def calculate_power(x, y, serial)
  rack_id = x + 10
  format('%03d', (((rack_id * y) + serial) * rack_id))[-3].to_i - 5
end

def run
  grid_size = 300
  serial = 6392
  power_grid = Array.new(grid_size) do |x|
    Array.new(grid_size) do |y|
      calculate_power(x + 1, y + 1, serial)
    end
  end

  best_power_value = nil
  best_power_coordinate = nil

  (0...(grid_size - 2)).each do |x|
    (0...(grid_size - 2)).each do |y|
      value = power_grid[x, 3].map { |inner| inner[y, 3].sum }.sum
      if best_power_value.nil? || value > best_power_value
        best_power_value = value
        best_power_coordinate = [x + 1, y + 1]
      end
    end
  end

  puts "[#{best_power_coordinate[0]},#{best_power_coordinate[1]}]: #{best_power_value}"
end

run
