require 'pry'
require 'json'

module Y2022
    module Day5
        module Part1
            def self.read_input
                File.readlines('2022/05/puzzle-input.txt').map(&:chomp)
            end

            def self.parse_sections input
                initial_state = input.take_while {|el| el != "" }
                instructions = input.drop(initial_state.size + 1)
                [initial_state, instructions]
            end

            def self.parse_stacks input
                last_line = input.last
                stacks = {}
                last_line.chars.each_with_index do |char, index|
                    if char != ' '
                        stacks[char.to_i] = []
                        input.reverse.drop(1).each do |line|
                            if line.size >= index + 1 && line.chars[index] != ' '
                                stacks[char.to_i].prepend(line.chars[index])
                            end
                        end
                    end
                end
                stacks
            end

            def self.parse_instructions input
                input.map do |line|
                    line.match(/move (?<move>\d+) from (?<from>\d+) to (?<to>\d+)/).named_captures.map do |key, value|
                        [key.to_sym, value.to_i]
                    end.to_h
                end
            end

            def self.perform_instruction state, instruction
                taken = state[instruction[:from]].shift(instruction[:move])
                state[instruction[:to]].unshift(*taken.reverse)
            end

            def self.perform_instructions state, instructions
                instructions.each do |instruction|
                    self.perform_instruction state, instruction
                end
            end

            def self.solve input=nil
                input = self.read_input unless input
                raw_state, raw_instructions = self.parse_sections input
                state = self.parse_stacks raw_state
                instructions = self.parse_instructions raw_instructions
                self.perform_instructions state, instructions
                state.keys.sort.map {|key| state[key].first || ' '}.join
            end
        end
    end
end
