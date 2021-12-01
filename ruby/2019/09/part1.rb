require 'logger'

module Y2019
    module Day9
        module Part1
            def self.op_mode091(opcode)
                [
                    (opcode / 100) % 10,
                    (opcode / 1000) % 10,
                    (opcode / 10000)
                ]
            end

            def self.param_locations091(program, op_mode, position, relative_base)
                (0..2).map do |n|
                    if op_mode[n] == 0
                        program[position + 1 + n]
                    elsif op_mode[n] == 1
                        position + 1 + n
                    elsif op_mode[n] == 2
                        program[position + 1 + n] + relative_base
                    else
                        raise Exception.new("Invalid op_mode at position #{position}, found instruction #{program[position]}.\n#{program}")
                    end
                end
            end

            def self.process_program091(program, inputs=nil)
                logger = Logger.new(STDOUT)
                logger.level = Logger::INFO

                position = 0
                relative_base = 0
                input_position = 0 unless inputs.nil?
                outputs = []
                while true
                    op_mode = op_mode091 program[position]
                    op = program[position] % 100
                    param_location = param_locations091(program, op_mode, position, relative_base)

                    case op
                    when 1 # add
                        logger.debug("#{program.slice(position, 4).join(',')}")
                        logger.debug("[#{position}] Add mode #{op_mode.first 3}, #{param_location.first(3).map{|index| program[index]}}")
                        program[param_location[2]] = (program[param_location[0]] || 0) + (program[param_location[1]] || 0)
                        position += 4
                    when 2 # multiply
                        logger.debug("#{program.slice(position, 4).join(',')}")
                        logger.debug("[#{position}] Multiply mode #{op_mode.first 3}, #{param_location.first(3).map{|index| program[index]}}")
                        program[param_location[2]] = (program[param_location[0]] || 0) * (program[param_location[1]] || 0)
                        position += 4
                    when 3 # input
                        logger.debug("#{program.slice(position, 2).join(',')}")
                        logger.debug("[#{position}] Input mode #{op_mode.first 1}, #{param_location.first(1).map{|index| program[index]}}")
                        if inputs.nil?
                            print "> "
                            STDOUT.flush
                            program[param_location[0]] = gets.chomp.to_i
                        else
                            program[param_location[0]] = inputs[input_position]
                            input_position += 1
                        end
                        position += 2
                    when 4 # output
                        logger.debug("#{program.slice(position, 2).join(',')}")
                        logger.debug("[#{position}] Output mode #{op_mode.first 2}, #{param_location.first(2).map{|index| program[index]}}")
                        #puts (program[param_location[0]] || 0)
                        outputs << (program[param_location[0]] || 0)
                        position += 2
                    when 5 # jump-if-true
                        logger.debug("#{program.slice(position, 3).join(',')}")
                        logger.debug("[#{position}] Jump-if-true mode #{op_mode.first 2}, #{param_location.first(2).map{|index| program[index]}}")
                        if (program[param_location[0]] || 0) != 0
                            position = (program[param_location[1]] || 0)
                        else
                            position += 3
                        end
                    when 6 # jump-if-false
                        logger.debug("#{program.slice(position, 3).join(',')}")
                        logger.debug("[#{position}] Jump-if-false mode #{op_mode.first 2}, #{param_location.first(2).map{|index| program[index]}}")
                        if (program[param_location[0]] || 0) == 0
                            position = (program[param_location[1]] || 0)
                        else
                            position += 3
                        end
                    when 7 # less than
                        logger.debug("#{program.slice(position, 4).join(',')}")
                        logger.debug("[#{position}] Less-than mode #{op_mode.first 3}, #{param_location.first(3).map{|index| program[index]}}")
                        program[param_location[2]] = (program[param_location[0]] || 0) < (program[param_location[1]] || 0) ? 1 : 0
                        position += 4
                    when 8 # equals
                        logger.debug("#{program.slice(position, 4).join(',')}")
                        logger.debug("[#{position}] Equals mode #{op_mode.first 3}, #{param_location.first(3).map{|index| program[index]}}")
                        program[param_location[2]] = (program[param_location[0]] || 0) == (program[param_location[1]] || 0) ? 1 : 0
                        position += 4
                    when 9 # change base
                        logger.debug("#{program.slice(position, 2).join(',')}")
                        logger.debug("[#{position}] Change Base mode #{op_mode.first 1}, #{param_location.first(1).map{|index| program[index]}}")
                        relative_base += (program[param_location[0]] || 0)
                        position += 2
                    when 99 # exit
                        logger.debug("#{program[position]}")
                        logger.debug("[#{position}] Exit")
                        break
                    else
                        raise Exception.new("Invalid instruction at position #{position}, found instruction #{program[position]}.\n#{program}")
                    end
                end
                return outputs
            end

            if __FILE__ == $0
                input = File.read('2019/09/puzzle-input.txt')
                program = input.chomp.split(',').map { |string_ops| string_ops.to_i }

                result = process_program091(program, [1])
                puts result.inspect
            end

            #473 too low
            #156439 too high
        end
    end
end