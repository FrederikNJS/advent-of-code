require 'pry'
input = File.read('05/puzzle-input.txt').strip

previous = input
current = ''
loop_count = 0
loop do
  loop_count += 1
  current = ''
  skip_next = false
  (0...(previous.length - 1)).each do |x|
    if skip_next
      skip_next = false
      next
    end
    if (previous[x].ord - previous[x + 1].ord).abs == 32
      skip_next = true
      next
    else
      current += previous[x]
    end
  end
  current += previous[-1]
  break if previous.size == current.size
  previous = current
  puts "Loop: #{loop_count}, size: #{current.size}"
end

puts "Final length is #{current.size}"
