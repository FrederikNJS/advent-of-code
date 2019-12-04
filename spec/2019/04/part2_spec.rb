require_relative '../../../2019/04/part2.rb'

RSpec.describe '2019/04/Part2' do
    it 'should detect adjacent digits' do
        expect(has_adjacent_digits? 111111).to be true
        expect(has_adjacent_digits? 223450).to be true
        expect(has_adjacent_digits? 123789).to be false
    end

    it 'should detect increasing digits' do
        expect(has_increasing_digits? 111111).to be true
        expect(has_increasing_digits? 223450).to be false
        expect(has_increasing_digits? 123789).to be true
    end

    it 'should detect whether the largest group has more than 2 members' do
        expect(has_adjacent_double? 112233).to be true
        expect(has_adjacent_double? 123444).to be false
        expect(has_adjacent_double? 111122).to be true
        expect(has_adjacent_double? 124444).to be false
        expect(has_adjacent_double? 112222).to be true
        expect(has_adjacent_double? 388889).to be false


        expect(has_adjacent_double? 456678).to be true
        expect(has_adjacent_double? 456679).to be true
        expect(has_adjacent_double? 456689).to be true
        expect(has_adjacent_double? 457789).to be true
        expect(has_adjacent_double? 467789).to be true
        expect(has_adjacent_double? 567789).to be true

    end

end
