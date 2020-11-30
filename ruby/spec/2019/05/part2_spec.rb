require_relative '../../../2019/05/part2.rb'

RSpec.describe '2019/05/Part2' do
    it 'handles the first example' do
        program = [3,9,8,9,10,9,4,9,99,-1,8]
        input = [5]
        result = process_program052(program.clone, input)
        expect(result).to eq [0]

        input = [8]
        result = process_program052(program.clone, input)
        expect(result).to eq [1]

        input = [10]
        result = process_program052(program.clone, input)
        expect(result).to eq [0]
    end

    it 'handles the second example' do
        program = [3,9,7,9,10,9,4,9,99,-1,8]
        input = [5]
        result = process_program052(program.clone, input)
        expect(result).to eq [1]

        input = [8]
        result = process_program052(program.clone, input)
        expect(result).to eq [0]

        input = [10]
        result = process_program052(program.clone, input)
        expect(result).to eq [0]
    end

    it 'handles the third example' do
        program = [3,3,1108,-1,8,3,4,3,99]
        input = [5]
        result = process_program052(program.clone, input)
        expect(result).to eq [0]

        input = [8]
        result = process_program052(program.clone, input)
        expect(result).to eq [1]

        input = [10]
        result = process_program052(program.clone, input)
        expect(result).to eq [0]
    end

    it 'handles the fourth example' do
        program = [3,3,1107,-1,8,3,4,3,99]
        input = [5]
        result = process_program052(program.clone, input)
        expect(result).to eq [1]

        input = [8]
        result = process_program052(program.clone, input)
        expect(result).to eq [0]

        input = [10]
        result = process_program052(program.clone, input)
        expect(result).to eq [0]
    end

    it 'handles the first jump example' do
        program = [3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9]
        input = [0]
        result = process_program052(program.clone, input)
        expect(result).to eq [0]

        input = [5]
        result = process_program052(program.clone, input)
        expect(result).to eq [1]
    end

    it 'handles a bigger program' do
        program = [
            3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,
            1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,
            999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99]
        input = [7]
        result = process_program052(program.clone, input)
        expect(result).to eq [999]

        input = [8]
        result = process_program052(program.clone, input)
        expect(result).to eq [1000]

        input = [9]
        result = process_program052(program.clone, input)
        expect(result).to eq [1001]
    end
end
