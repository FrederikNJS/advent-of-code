
require 'pry'
require 'ruby-progressbar'
require_relative '../11/part1.rb'

module Day201919
    if __FILE__ == $0
        input = File.read('2019/19/puzzle-input.txt')
        program = input.chomp.split(',').map { |string_ops| string_ops.to_i }

        count = 0
        view = Array.new(100) {
            Array.new(100) {
                " "
            }
        }

        (0...50).each do |x|
            (0...50).each do |y|
                inputs = Array.new
                outputs = Array.new
                inputs.prepend x
                inputs.prepend y
                process_program111(program.clone, inputs, outputs)
                result = outputs.pop
                if result == 1
                    count += 1
                    view[y][x] = "#"
                end
            end
        end

        view.each do |row|
            puts row.join
        end

        puts count
    end
end
