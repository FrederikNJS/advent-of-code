def process_program2(program, noun, verb)
    program = program.clone
    program[1] = noun
    program[2] = verb
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

def brute_search(program)
    (0..99).each do |noun|
        (0..99).each do |verb|
            puts "trying #{noun}, #{verb}"
            result = process_program2 program, noun, verb
            if result[0] == 19_690_720
                return {noun: noun, verb: verb}
            end
        end
    end

end

if __FILE__ == $0
    input = File.read('2019/02/puzzle-input.txt')
    program = input.chomp.split(',').map { |string_ops| string_ops.to_i }
    result = brute_search program
    puts result
    puts 100 * result[:noun] + result[:verb]
end
