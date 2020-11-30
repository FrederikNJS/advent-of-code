require 'pry'

class Track
  def initialize(lines)
    height = lines.size
    width = lines.map(&:size).max
    @track_pieces = Array.new(width) { Array.new(height, nil) }
    lines.each_with_index do |line, y|
      line.split('').each_with_index do |field, x|
        @track_pieces[x][y] = if %w[< >].include? field
                                '-'
                              elsif %w[^ v].include? field
                                '|'
                              else
                                field
                              end
      end
    end
    binding.pry
  end

  def print
    @track_pieces.transpose.each do |row|
      puts row.join
    end
  end
end

class Vehicle
  def initialize(direction, x, y)
    @direction = direction
    @x = x
    @y = y
  end
end

def main
  lines = File.readlines('2018/13/test-input.txt').map { |line| line.chomp '\r\n' }
  track = Track.new lines
  binding.pry
end

main()
