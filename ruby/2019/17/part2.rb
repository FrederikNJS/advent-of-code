
require 'pry'
require 'ruby-progressbar'
require_relative '../11/part1.rb'

module Day201917
    if __FILE__ == $0
        input = File.read('2019/17/puzzle-input.txt')
        program = input.chomp.split(',').map { |string_ops| string_ops.to_i }
        program[0] = 2

        inputs = Queue.new
        outputs = Queue.new
        waiting_for_input = Queue.new

        thread = Thread.new {
            process_program111(program, inputs, outputs, waiting_for_input)
        }

        test = waiting_for_input.pop

        main_routine = "A,B,A,B,C,B,C,A,C,C\n"

        a_routine = "R,12,L,10,L,10\n"
        b_routine = "L,6,L,12,R,12,L,4\n"
        c_routine = "L,12,R,12,L,6\n"
        camera = "n\n"
        full_input = "#{main_routine}#{a_routine}#{b_routine}#{c_routine}#{camera}"

        ascii = full_input.chars.map {|chr| chr.ord }
        ascii.each {|n| inputs << n}

        ary = []
        while thread.alive? || !outputs.empty?
            ary << outputs.pop
        end
        puts ary.last
    end
end
