require_relative '../../../2019/02/part1.rb'

RSpec.describe '2019/02/Part1' do
    it 'calculates fuel correctly' do
        expect(process_program [1,9,10,3,2,3,11,0,99,30,40,50]).to eq [3500,9,10,70,2,3,11,0,99,30,40,50]
        expect(process_program [1,0,0,0,99]).to eq [2,0,0,0,99]
        expect(process_program [2,3,0,3,99]).to eq [2,3,0,6,99]
        expect(process_program [2,4,4,5,99,0]).to eq [2,4,4,5,99,9801]
        expect(process_program [1,1,1,4,99,5,6,0,99]).to eq [30,1,1,4,2,5,6,0,99]
    end
end
