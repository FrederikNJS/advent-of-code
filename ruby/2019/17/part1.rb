require 'pry'
require 'ruby-progressbar'
require_relative '../11/part1.rb'

module Day201917
    if __FILE__ == $0
        input = File.read('2019/17/puzzle-input.txt')
        program = input.chomp.split(',').map { |string_ops| string_ops.to_i }

        inputs = Queue.new
        outputs = Queue.new

        #thread = Thread.new {
            process_program111(program, inputs, outputs)
        #}

        ary = []

        until outputs.empty?
            ary << outputs.pop.chr
        end

        str = ary.join
        grid = str.lines.map { |line| line.chomp.chars }

        crosses = []

        grid.each.with_index do |line, y|
            line.each.with_index do |char, x|
                if y > 0 && y < grid.length - 1 &&
                    x > 0 && x < line.length - 1 && char == '#' &&
                    grid[y-1][x] == '#' &&
                    grid[y+1][x] == '#' &&
                    grid[y][x-1] == '#' &&
                    grid[y][x+1] == '#'
                    crosses << [x, y]
                end
            end
        end

        alignment = crosses.reduce(0) do |a, b|
            a + (b[0] * b[1])
        end

        grid.each do |x|
            puts x.join
        end
        puts alignment
    end
end
