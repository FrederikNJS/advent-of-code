require_relative 'part1.rb'

module Y2022
    module Day5
        module Part2
            @part1 = Y2022::Day5::Part1

            def self.perform_instruction state, instruction
                taken = state[instruction[:from]].shift(instruction[:move])
                state[instruction[:to]].unshift(*taken)
            end

            def self.perform_instructions state, instructions
                instructions.each do |instruction|
                    self.perform_instruction state, instruction
                end
            end

            def self.solve input=nil
                input = @part1.read_input unless input
                raw_state, raw_instructions = @part1.parse_sections input
                state = @part1.parse_stacks raw_state
                instructions = @part1.parse_instructions raw_instructions
                self.perform_instructions state, instructions
                state.keys.sort.map {|key| state[key].first || ' '}.join
            end
        end
    end
end
