require_relative '../11/part1.rb'
require 'pry'

module Day201923
    if __FILE__ == $0
        input = File.read('2019/25/puzzle-input.txt')
        program = input.chomp.split(',').map { |string_ops| string_ops.to_i }

        input = Queue.new
        output = Queue.new

        thread = Thread.new {
            process_program111(program.clone, input, output)
        }

        out_thread = Thread.new {
            while true
                print output.pop.chr
            end
        }

        while true
            keys = gets
            keys.chars.each do |chr|
                input << chr.ord
            end
        end
    end
end
