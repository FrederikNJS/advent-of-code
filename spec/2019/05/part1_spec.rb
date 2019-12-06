require_relative '../../../2019/05/part1.rb'

RSpec.describe '2019/05/Part1' do
    it 'can handle opcodes' do
        expect(op_mode 10099).to eq [false, false, true]
        expect(op_mode 1099).to eq [false, true, false]
        expect(op_mode 199).to eq [true, false, false]
        expect(op_mode 1199).to eq [true, true, false]
        expect(op_mode 11099).to eq [false, true, true]
        expect(op_mode 11199).to eq [true, true, true]
    end
end
