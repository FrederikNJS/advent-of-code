require 'pry'

def read_input
  File.read('2018/08/puzzle-input.txt')
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

  def value
    if @children.empty?
      @metadata.sum
    else
      @metadata.map(&method(:child_value)).sum
    end
  end

  def child_value(child_index)
    if child_index.zero?
      0
    elsif @children[child_index - 1].nil?
      0
    else
      @children[child_index - 1].value
    end
  end
end


def run
  input = read_input
  tree = Node.new input, 0
  puts tree.value
end

run
