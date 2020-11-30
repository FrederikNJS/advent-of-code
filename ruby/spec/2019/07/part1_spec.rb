require_relative '../../../2019/07/part1.rb'

RSpec.describe '2019/07/Part1' do
    it 'it works on the first input' do
        program = [3,15,3,16,1002,16,10,16,1,16,15,15,4,15,99,0,0]
        result = max_thruster_setting program
        expect(result).to eq 43210
    end
end
