sum = 0
File.readlines('01/puzzle-input.txt').map(&:strip).each do |line|
  number = line.to_i
  sum += number
  puts sum
end
puts "Answer is #{sum}"
