require 'pry'

def read_input
  File.read('08/puzzle-input.txt')
      .strip
      .split(' ')
      .map(&:to_i)
end

class Node
  def initialize(input, depth)
    @node_count = input.shift
    @metadata_count = input.shift
    @children = []
    @node_count.times do
      @children << Node.new(input, depth + 1)
    end
    @metadata = input.shift @metadata_count
  end

  def sum_metadata
    @children.map(&:sum_metadata).sum + @metadata.sum
  end
end


def run
  input = read_input
  tree = Node.new input, 0
  puts tree.sum_metadata
end

run
