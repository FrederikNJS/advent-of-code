lines = File.readlines('02/puzzle-input.txt').map {|line| line.strip}

two_counter = 0
three_counter = 0

# O(n * k)
lines.each do |line|
  freqs = {}
  freqs.default = 0
  line.split('').each do |char| #O(n)
    freqs[char] += 1
  end
  if freqs.value? 2 #O(n)
    two_counter += 1
  end
  if freqs.value? 3 #O(n)
    three_counter += 1
  end
end

puts "Checksum is #{two_counter * three_counter}"
