lines = File.readlines('03/puzzle-input.txt').map(&:strip)

regex = /^#\d+ @ (?<x>\d+),(?<y>\d+): (?<width>\d+)x(?<height>\d+)$/

cuts = lines.map { |line| regex.match line }
            .map do |match|
              {
                x: match[:x].to_i,
                y: match[:y].to_i,
                width: match[:width].to_i,
                height: match[:height].to_i
              }
            end

cloth = Array.new(1000) { Array.new(1000, 0) }

cuts.each do |cut|
  (cut[:x]...(cut[:x] + cut[:width])).each do |x|
    (cut[:y]...(cut[:y] + cut[:height])).each do |y|
      cloth[x][y] += 1
    end
  end
end

overlapped_squares = cloth.flatten.count { |point| point > 1 }

puts overlapped_squares
