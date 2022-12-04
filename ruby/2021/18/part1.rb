require 'immutable'
require 'pry'
require 'json'

module Y2021
    module Day18
        module Part1
            def self.read_input
                File.readlines('2021/18/puzzle-input.txt').map(&:chomp)
            end

            def self.parse_input raw
                raw.map { |line| JSON.parse line }
            end

            def self.inject(pair, shock)
                shock_left, shock_right = shock
                if shock_left
                    if pair[1].class == Integer
                        [pair[0], pair[1] + shock_left]
                    else
                        self.inject pair[1], shock
                    end
                elsif shock_right
                    if pair[0].class == Integer
                        [pair[0] + shock_right, pair[1]]
                    else
                        self.inject pair[0], shock
                    end
                end
            end

            def self.explode input, level=0
                left, right = input
                if level >= 4
                    [ 0, [left, right] ]
                else
                    outer_shock = [nil, nil]
                    if left.class == Array
                        left, shock = self.explode left, level+1
                        if shock[1]
                            if right.class == Array
                                right = self.inject(right, [nil, shock[1]])
                            else
                                right = right + shock[1]
                            end
                            shock[1] = nil
                        end
                        # TODO: WTF?
                        if shock[0] &&
                            outer_shock[0] = shock[0]
                        end
                    end
                    if right.class == Array
                        right, shock = self.explode right, level+1
                        if shock[0]
                            if left.class == Array
                                left = self.inject(left, [shock[0], nil])
                            else
                                left = left + shock[0]
                            end
                            shock[0] = nil
                        end
                        outer_shock[1] = shock[1]
                    end
                    [[left, right], outer_shock]
                end
            end

            def self.split input
                input.map do |item|
                    if item.class == Array
                        self.split item
                    elsif item > 9
                        half_down = item / 2
                        [half_down, item - half_down]
                    else
                        item
                    end
                end
            end

            def self.reduce input
                stringified_input = JSON.generate input
                loop do
                    input, _ = self.explode input
                    stringified_output = JSON.generate input
                    puts stringified_output
                    if stringified_input != stringified_output
                        stringified_input = stringified_output
                        next
                    end
                    stringified_input = stringified_output
                    input = self.split input
                    stringified_output = JSON.generate input
                    puts stringified_output
                    if stringified_input != stringified_output
                        stringified_input = stringified_output
                        next
                    end
                    break
                end
                input
            end

            def self.sequence sequence
                result = sequence.shift
                until sequence.empty?
                    input = [result, sequence.shift]
                    #puts("input: #{JSON.generate(input)}")
                    result = self.reduce(input)
                    #puts("output: #{JSON.generate(result)}")
                end
                result
            end

            def self.magnitude input
                left, right = input
                if left.class == Array
                    left = self.magnitude left
                end
                if right.class == Array
                    right = self.magnitude right
                end
                left * 3 + right * 2
            end
        end
    end
end
