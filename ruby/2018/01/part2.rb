require 'set'

sum = 0
seen = Set.new
collision = false
File.readlines('2018/01/puzzle-input.txt').map {|line| line.strip}.cycle do |line|
  number = line.to_i
  sum += number
  if seen.include? sum
    puts "Collision! #{sum}"
    collision = true
    break
  end
  seen.add sum
  puts sum
end
puts "WAT‽" unless collision
