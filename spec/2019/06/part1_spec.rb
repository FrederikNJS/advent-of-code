require_relative '../../../2019/06/part1.rb'

RSpec.describe '2019/06/Part1' do
    it 'it can find orbit counts' do
        my_str = <<-FOO
COM)B
B)C
C)D
D)E
E)F
B)G
G)H
D)I
E)J
J)K
K)L
FOO
        lines = my_str.lines.map(&:chomp)
        result = orbit_counter lines
        expect(result).to eq 42
    end

    it 'it can find orbit counts, when orbits are out of order' do
        my_str = <<-FOO
COM)B
K)L
B)C
C)D
D)E
E)F
B)G
G)H
D)I
E)J
J)K
FOO
        lines = my_str.lines.map(&:chomp)
        result = orbit_counter lines
        expect(result).to eq 42
    end
end
