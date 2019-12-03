require_relative '../../../2019/03/part1.rb'

RSpec.describe '2019/03/Part1' do
    it 'can parse an instruction' do
        expect(parse_instruction('R17')).to eq({direction: 'R', length: 17})
    end

    it 'can build paths' do
        instructions = [
            {direction: 'R', length: 8},
            {direction: 'U', length: 5},
            {direction: 'L', length: 5},
            {direction: 'D', length: 3}
        ]

        expected = [
            {x: 1, y: 0},
            {x: 2, y: 0},
            {x: 3, y: 0},
            {x: 4, y: 0},
            {x: 5, y: 0},
            {x: 6, y: 0},
            {x: 7, y: 0},
            {x: 8, y: 0},
            {x: 8, y: 1},
            {x: 8, y: 2},
            {x: 8, y: 3},
            {x: 8, y: 4},
            {x: 8, y: 5},
            {x: 7, y: 5},
            {x: 6, y: 5},
            {x: 5, y: 5},
            {x: 4, y: 5},
            {x: 3, y: 5},
            {x: 3, y: 4},
            {x: 3, y: 3},
            {x: 3, y: 2},
        ]

        expect(build_path(instructions)).to eq expected
    end

    it 'finds intersections' do
        a = ['R8','U5','L5','D3'].map { |item| parse_instruction item}
        b = ['U7','R6','D4','L4'].map { |item| parse_instruction item}
        path_a = build_path a
        path_b = build_path b
        expect(find_intersections(path_a, path_b)). to eq Set[{x: 3, y: 3}, {x: 6, y: 5}]
    end

    it 'finds the closest intersection' do
        intersections = Set[{x: 3, y: 3}, {x: 6, y: 5}]
        expect(closest_intersection(intersections)). to eq({x: 3, y: 3})
    end

    it 'can calculate the closest intersection distance directly' do
        instructions_a = ['R75','D30','R83','U83','L12','D49','R71','U7','L72']
        instructions_b = ['U62','R66','U55','R34','D71','R55','D58','R83']
        result = harness(instructions_a, instructions_b)
        expect(result).to eq(159)

        instructions_a = ['R98','U47','R26','D63','R33','U87','L62','D20','R33','U53','R51']
        instructions_b = ['U98','R91','D20','R16','D67','R40','U7','R15','U6','R7']
        result = harness(instructions_a, instructions_b)
        expect(result).to eq(135)
    end
end
