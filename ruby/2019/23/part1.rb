
require 'pry'
require 'ruby-progressbar'
require_relative '../11/part1.rb'

def process_program231(program, inputs, outputs, waiting_for_input=nil)
    logger = Logger.new(STDOUT)
    logger.level = Logger::INFO

    position = 0
    relative_base = 0
    while true
        op_mode = op_mode111 program[position]
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
            waiting_for_input << true unless waiting_for_input.nil?
            program[param_location[0]] = inputs.pop
            #program[param_location[0]] = ((inputs.empty?) ? (-1) : (inputs.pop))
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
            waiting_for_input << false unless waiting_for_input.nil?
            break
        else
            raise Exception.new("Invalid instruction at position #{position}, found instruction #{program[position]}.\n#{program}")
        end
    end
end


module Day201923
    NetworkInstance = Struct.new(:in, :out, :thread)
    if __FILE__ == $0
        input = File.read('2019/23/puzzle-input.txt')
        program = input.chomp.split(',').map { |string_ops| string_ops.to_i }

        queues = (0..49).map do |n|
            input = Queue.new
            input << n
            [input, Queue.new]
        end

        instances = queues.map.map do |input, output|
            thread = Thread.new {
                process_program231(program.clone, input, output)
            }
            NetworkInstance.new(input, output, thread)
        end

        while true
            instances.each do |instance|
                unless(instance.out.empty?)
                    dest = instance.out.pop
                    x = instance.out.pop
                    y = instance.out.pop
                    puts "dest: #{dest}"
                    if dest == 255
                        puts x
                        puts y
                        exit(0)
                    end

                    instances[dest].in << x
                    instances[dest].in << y
                end
            end
        end
    end
end
