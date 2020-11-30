
require 'pry'
require 'ruby-progressbar'
require_relative '../11/part1.rb'

module Day201919
    if __FILE__ == $0
        input = File.read('2019/21/puzzle-input.txt')
        program = input.chomp.split(',').map { |string_ops| string_ops.to_i }

        inputs = Queue.new
        outputs = Queue.new
        waiting_for_input = Queue.new
        thread = Thread.new {
            process_program111(program.clone, inputs, outputs, waiting_for_input)
        }

        waiting_for_input.pop
        puts "=======\n"
        until outputs.empty?
            print outputs.pop.chr
        end
        puts "=======\n"

        instructions = [
            "NOT A T",
            "OR T J",
            "NOT B T",
            "OR T J",
            "NOT C T",
            "OR T J",
            "AND D J",
            "WALK\n"
        ]

        instructions.join("\n").chars.each do |c|
            inputs << c.ord
        end

        sleep(10)

        puts "=======\n"
        until outputs.empty?
            out = outputs.pop
            if (0..127).include? out
                print out.chr
            else
                print out
            end
        end
        puts "=======\n"

    end
end
