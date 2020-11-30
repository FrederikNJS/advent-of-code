require_relative '../../../2019/01/part1.rb'

RSpec.describe "2019/01/Part1" do
    it 'calculates fuel correctly' do
        expect(fuel_calc1 12).to equal 2
        expect(fuel_calc1 14).to equal 2
        expect(fuel_calc1 1969).to equal 654
        expect(fuel_calc1 100756).to equal 33583
    end
end
