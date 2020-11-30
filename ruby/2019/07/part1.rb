def op_mode(opcode)
    [
        (opcode / 100) % 10 == 1,
        (opcode / 1000) % 10 == 1,
        (opcode / 10000) == 1
    ]
end

def process_program071(program, inputs=nil)
    position = 0
    input_position = 0 unless inputs.nil?
    outputs = []
    while true
        op_mode = op_mode program[position]
        op = program[position] % 100
        param_location = [
            op_mode[0] ? position + 1 : program[position + 1],
            op_mode[1] ? position + 2 : program[position + 2],
            op_mode[2] ? position + 3 : program[position + 3],
        ]
#        binding.pry

        case op
        when 1 # add
            program[program[position + 3]] = program[param_location[0]] + program[param_location[1]]
            position += 4
        when 2 # multiply
            program[program[position + 3]] = program[param_location[0]] * program[param_location[1]]
            position += 4
        when 3 # input
            if inputs.nil?
                print "> "
                STDOUT.flush
                program[program[position + 1]] = gets.chomp.to_i
            else
                program[program[position + 1]] = inputs[input_position]
                input_position += 1
            end
            position += 2
        when 4 # output
            #puts program[param_location[0]]
            outputs << program[param_location[0]]
            position += 2
        when 5 # jump-if-true
            if program[param_location[0]] != 0
                position = program[param_location[1]]
            else
                position += 3
            end
        when 6 # jump-if-false
            if program[param_location[0]] == 0
                position = program[param_location[1]]
            else
                position += 3
            end
        when 7 # less than
            program[program[position + 3]] = (program[param_location[0]] < program[param_location[1]]) ? 1 : 0
            position += 4
        when 8 # equals
            program[program[position + 3]] = (program[param_location[0]] == program[param_location[1]]) ? 1 : 0
            position += 4
        when 99 # exit
            break
        else
            raise Exception.new("Invalid instruction at position #{position}, found instruction #{program[position]}.\n#{program}")
        end
    end
    return outputs
end

def max_thruster_setting(program)
    permutations = [0, 1, 2, 3, 4].permutation
    total_result = 0
    permutations.each do |permutation|
        last_output = 0
        permutation.each do |stage|
            last_output = process_program071(program.clone, [stage, last_output])[0]
        end
        total_result = last_output if last_output > total_result
    end
    total_result
end

if __FILE__ == $0
    input = File.read('2019/07/puzzle-input.txt')
    program = input.chomp.split(',').map { |string_ops| string_ops.to_i }

    #program = [3,15,3,16,1002,16,10,16,1,16,15,15,4,15,99,0,0]
    result = max_thruster_setting program
    puts result
end

#473 too low
#156439 too high
