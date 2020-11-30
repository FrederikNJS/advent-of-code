require_relative '../../../2019/01/part2.rb'

RSpec.describe "2019/01/Part2" do
    it 'calculates fuel correctly' do
        expect(fuel_calc2 14).to equal 2
        expect(fuel_calc2 1969).to equal 966
        expect(fuel_calc2 100756).to equal 50346
    end
end
