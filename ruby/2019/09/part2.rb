require 'logger'
require_relative 'part1'

if __FILE__ == $0
    input = File.read('2019/09/puzzle-input.txt')
    program = input.chomp.split(',').map { |string_ops| string_ops.to_i }

    result = process_program091(program, [2])
    puts result.inspect
end

#473 too low
#156439 too high
