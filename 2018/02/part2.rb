lines = File.readlines('2018/02/puzzle-input.txt').map {|line| line.strip}

# O(n^2)   :-(

lines.each do |line|
  lines.each do |line2|
    differences = 0
    for index in 0..line.size
      if line[index] != line2[index]
        differences += 1
      end
    end
    if differences == 1
      puts "found matching boxes:\n#{line}\n#{line2}\n\n"
    end
  end
end
