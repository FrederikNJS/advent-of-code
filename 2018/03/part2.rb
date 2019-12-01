lines = File.readlines('2018/03/puzzle-input.txt').map(&:strip)

regex = /^#(?<id>\d+) @ (?<x>\d+),(?<y>\d+): (?<width>\d+)x(?<height>\d+)$/

cuts = lines.map { |line| regex.match line }.map do |match|
  {
    id: match[:id].to_i,
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

cuts.each do |cut|
  alone = true
  (cut[:x]...(cut[:x] + cut[:width])).each do |x|
    (cut[:y]...(cut[:y] + cut[:height])).each do |y|
      if cloth[x][y] != 1
        alone = false
        break
      end
    end
    break unless alone
  end
  if alone
    puts cut
    break
  end
end
