require_relative '../../../2019/01/part2.rb'

RSpec.describe "2019/01/Part2" do
    part2 = Y2019::Day1::Part2
    it 'calculates fuel correctly' do
        expect(part2.fuel_calc2 14).to equal 2
        expect(part2.fuel_calc2 1969).to equal 966
        expect(part2.fuel_calc2 100756).to equal 50346
    end
end
