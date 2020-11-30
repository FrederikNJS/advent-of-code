require 'pry'
require 'ruby-progressbar'
require_relative '../11/part1.rb'

module Day201919
    def Day201919.test(program, cache, x, y)
        if cache.key? [x, y]
            return cache[[x, y]]
        end
        inputs = Array.new
        outputs = Array.new
        inputs.prepend x
        inputs.prepend y
        process_program111(program.clone, inputs, outputs)
        cache[[x, y]] = outputs[0] == 1
        outputs[0] == 1
    end

    if __FILE__ == $0
        input = File.read('2019/19/puzzle-input.txt')
        program = input.chomp.split(',').map { |string_ops| string_ops.to_i }

        count = 0
        cache = {}

        iter = 0

        x = (500...1000).bsearch do |x|
            iter += 1
            puts iter
            y = (500...1000).find do |y|
                ul = test(program, cache, x, y)
                ur = test(program, cache, x+99, y)
                ll = test(program, cache, x, y+99)
                lr = test(program, cache, x+99, y+99)
                ul && ur && ll && lr
            end
            !y.nil?
        end

        y = (500...1000).find do |y|
            test(program, cache, x, y) && test(program, cache, x+99, y) && test(program, cache, x, y+99) && test(program, cache, x+99, y+99)
        end

        puts x
        puts y

        puts x * 10000 + y
    end
end

#Coordinate: (695, 903) = (6950903)
