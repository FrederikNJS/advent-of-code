require_relative '../../../2019/10/part1.rb'

RSpec.describe '2019/10/Part1' do
    it 'can get the astroid indices' do
        asteroid_map = [
            '.#..#',
            '.....',
            '#####',
            '....#',
            '...##'
        ]

        expected = Set[
            Asteroid.new(1, 0),
            Asteroid.new(4, 0),
            Asteroid.new(0, 2),
            Asteroid.new(1, 2),
            Asteroid.new(2, 2),
            Asteroid.new(3, 2),
            Asteroid.new(4, 2),
            Asteroid.new(4, 3),
            Asteroid.new(3, 4),
            Asteroid.new(4, 4),
        ]

        result = get_asteroids asteroid_map
        expect(result).to eq expected
    end

    it 'can calculate distance from a point to a line' do
        point_1 = Asteroid.new(0, 0)
        point_2 = Asteroid.new(3, 0)
        point_3 = Asteroid.new(2, 0)

        distance = point_distance_from_line(point_1, point_2, point_3)
        expect(distance).to eq 0

        point_1 = Asteroid.new(0, 0)
        point_2 = Asteroid.new(2, 2)
        point_3 = Asteroid.new(1, 1)

        distance = point_distance_from_line(point_1, point_2, point_3)
        expect(distance).to eq 0

        point_1 = Asteroid.new(0, 0)
        point_2 = Asteroid.new(3, 0)
        point_3 = Asteroid.new(2, 1)

        distance = point_distance_from_line(point_1, point_2, point_3)
        expect(distance).to eq 1

        point_1 = Asteroid.new(0, 0)
        point_2 = Asteroid.new(3, 3)
        point_3 = Asteroid.new(4, 4)

        distance = point_distance_from_line(point_1, point_2, point_3)
        expect(distance).to eq 0
    end

    it 'can calculate whether an asteroid is visible' do
        asteroid_map = [
            '.#..#',
            '.....',
            '#####',
            '....#',
            '...##'
        ]
        asteroids = get_asteroids asteroid_map
        origin = Asteroid.new(1, 0)

        expect(asteroid_visible?(origin, Asteroid.new(4, 0), asteroids)).to be true
        expect(asteroid_visible?(origin, Asteroid.new(0, 2), asteroids)).to be true
        expect(asteroid_visible?(origin, Asteroid.new(1, 2), asteroids)).to be true
        expect(asteroid_visible?(origin, Asteroid.new(2, 2), asteroids)).to be true
        expect(asteroid_visible?(origin, Asteroid.new(3, 2), asteroids)).to be true
        expect(asteroid_visible?(origin, Asteroid.new(4, 2), asteroids)).to be true
        expect(asteroid_visible?(origin, Asteroid.new(4, 3), asteroids)).to be false
        expect(asteroid_visible?(origin, Asteroid.new(3, 4), asteroids)).to be false
        expect(asteroid_visible?(origin, Asteroid.new(4, 4), asteroids)).to be true
    end

    it 'can calculate the number of visible asteroids from a single asteroid' do
        asteroid_map = [
            '.#..#',
            '.....',
            '#####',
            '....#',
            '...##'
        ]
        asteroids = get_asteroids asteroid_map
        visible_asteroids = find_visible_asteroids(
            Asteroid.new(1, 0),
            asteroids
        )

        expect(visible_asteroids.length).to eq 7
    end

    it 'it works on the first input' do
        asteroid_map = [
            '.#..#',
            '.....',
            '#####',
            '....#',
            '...##'
        ]

        asteroids = get_asteroids asteroid_map
        candidates = find_all_visibles asteroids
        result = find_best_candidate candidates

        expect(result).to eq [Asteroid.new(3, 4), 8]
    end

    it 'works on more examples' do
        asteroid_map = [
            '......#.#.',
            '#..#.#....',
            '..#######.',
            '.#.#.###..',
            '.#..#.....',
            '..#....#.#',
            '#..#....#.',
            '.##.#..###',
            '##...#..#.',
            '.#....####',
        ]

        asteroids = get_asteroids asteroid_map
        candidates = find_all_visibles asteroids
        result = find_best_candidate candidates
        expect(result).to eq [Asteroid.new(5, 8), 33]
    end
end
