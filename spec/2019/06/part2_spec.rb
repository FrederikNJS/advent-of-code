require_relative '../../../2019/06/part2.rb'

RSpec.describe '2019/06/Part2' do
    it 'it can build an orbit tree' do
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
        result = orbit_tree lines


        expected = {
            'B' => 'COM',
            'C' => 'B',
            'D' => 'C',
            'E' => 'D',
            'F' => 'E',
            'G' => 'B',
            'H' => 'G',
            'I' => 'D',
            'J' => 'E',
            'K' => 'J',
            'L' => 'K'
        }
        expect(result).to eq expected
    end

    it 'can build orbit paths' do
        my_str = <<-BAR
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
K)YOU
I)SAN
BAR

        lines = my_str.lines.map(&:chomp)
        tree = orbit_tree lines
        result = orbit_path(tree, 'YOU')
        expect(result).to eq ['K', 'J', 'E', 'D', 'C', 'B', 'COM']
    end

    it 'can build orbit paths' do
        my_str = <<-BAR
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
K)YOU
I)SAN
BAR
        lines = my_str.lines.map(&:chomp)
        tree = orbit_tree lines
        path_a = orbit_path(tree, 'YOU')
        path_b = orbit_path(tree, 'SAN')
        result  = orbit_route(path_a, path_b)
        expect(result).to eq 4
    end

end
