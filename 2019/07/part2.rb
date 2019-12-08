def op_mode(opcode)
    [
        (opcode / 100) % 10 == 1,
        (opcode / 1000) % 10 == 1,
        (opcode / 10000) == 1
    ]
end

def process_program072(program, input_queue, output_queue)
    position = 0
    outputs = []
    while true
        op_mode = op_mode program[position]
        op = program[position] % 100
        param_location = [
            op_mode[0] ? position + 1 : program[position + 1],
            op_mode[1] ? position + 2 : program[position + 2],
            op_mode[2] ? position + 3 : program[position + 3],
        ]

        case op
        when 1 # add
            program[program[position + 3]] = program[param_location[0]] + program[param_location[1]]
            position += 4
        when 2 # multiply
            program[program[position + 3]] = program[param_location[0]] * program[param_location[1]]
            position += 4
        when 3 # input
            program[program[position + 1]] = input_queue.pop
            position += 2
        when 4 # output
            output_queue << program[param_location[0]]
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
    return outputs[-1]
end

def max_thruster_setting72(program)
    permutations = [5,6,7,8,9].permutation
    total_result = 0
    permutations.each do |permutation|
        queues = permutation.map { |phase| Queue.new }
        threads = permutation.map.with_index do |phase, index|
            queues[index] << phase
            Thread.new {
                process_program072(program.clone, queues[index], queues[(index + 1) % 5])
            }
        end
        queues[0] << 0
        results = threads.map { |thread| thread.value}
        total_result = results[-1] if results[-1] > total_result
    end
    total_result
end

if __FILE__ == $0
    input = File.read('2019/07/puzzle-input.txt')
    program = input.chomp.split(',').map { |string_ops| string_ops.to_i }

    #program = [3,15,3,16,1002,16,10,16,1,16,15,15,4,15,99,0,0]
    result = max_thruster_setting72 program
    puts result
end

#473 too low
#156439 too high
