require_relative '../../../2019/09/part1.rb'

RSpec.describe '2019/09/Part1' do
    part1 = Y2019::Day9::Part1
    it 'it works on the first input' do
        program = 109,1,204,-1,1001,100,1,100,1008,100,16,101,1006,101,0,99
        result = part1.process_program091(program.clone, [])
        expect(result).to eq program
    end
end
