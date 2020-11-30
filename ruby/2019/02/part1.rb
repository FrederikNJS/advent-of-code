def process_program(program)
    position = 0
    while true
        case program[position]
        when 1
            program[program[position+3]] = program[program[position+1]] + program[program[position+2]]
        when 2
            program[program[position+3]] = program[program[position+1]] * program[program[position+2]]
        when 99
            break
        else
            raise Exception.new("Invalid instruction at position #{position}, found instruction #{program[position]}.\n#{program}")
        end
        position += 4
    end
    return program
end

if __FILE__ == $0
    input = File.read('2019/02/puzzle-input.txt')
    program = input.chomp.split(',').map { |string_ops| string_ops.to_i }
    puts program.inspect
    program[1] = 12
    program[2] = 2
    result = process_program program
    puts result[0]
end
