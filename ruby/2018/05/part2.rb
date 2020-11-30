require 'pry'
input = File.read('2018/05/puzzle-input.txt').strip

shortest_sequence = ('a'..'z').map do |letter|
  previous = input.delete letter + letter.upcase
  current = ''
  loop_count = 0
  loop do
    loop_count += 1
    current = ''
    skip_next = false
    (0...(previous.length-1)).each do |x|
      if skip_next
        skip_next = false
        next
      end
      if (previous[x].ord - previous[x+1].ord).abs == 32
        skip_next = true
        next
      else
        current += previous[x]
      end
    end
    current += previous[-1]
    break if previous.size == current.size
    previous = current
  end

  puts "Final length without #{letter} is #{current.size}"
  current.size
end.min

puts "The shortest sequence is: #{shortest_sequence}"
