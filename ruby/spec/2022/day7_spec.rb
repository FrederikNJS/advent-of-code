require_relative '../../2022/07/part1.rb'
require_relative '../../2022/07/part2.rb'

RSpec.describe "2022 Day 7" do
    part1 = Y2022::Day7::Part1
    part2 = Y2022::Day7::Part2

    context 'Part 1' do
        context "unit tests" do
            it 'parses instructions' do
                input = "$ cd /
$ ls
dir a
14848514 b.txt
8504156 c.dat
dir d
$ cd a
$ ls
dir e
29116 f
2557 g
62596 h.lst
$ cd e
$ ls
584 i
$ cd ..
$ cd ..
$ cd d
$ ls
4060174 j
8033020 d.log
5626152 d.ext
7214296 k".lines.map(&:chomp)

                out = part1.split_commands input
                expect(out).to eq [
                    ['cd /', []],
                    ['ls', [
                        'dir a',
                        '14848514 b.txt',
                        '8504156 c.dat',
                        'dir d'
                    ]],
                    ['cd a', []],
                    ['ls', [
                        'dir e',
                        '29116 f',
                        '2557 g',
                        '62596 h.lst'
                    ]],
                    ['cd e', []],
                    ['ls', [
                        '584 i'
                    ]],
                    ['cd ..', []],
                    ['cd ..', []],
                    ['cd d', []],
                    ['ls', [
                        '4060174 j',
                        '8033020 d.log',
                        '5626152 d.ext',
                        '7214296 k'
                    ]]
                ]
            end

            it 'can turn instructions into a filesystem model' do
                commands = [
                    ['cd /', []],
                    ['ls', [
                        'dir a',
                        '14848514 b.txt',
                        '8504156 c.dat',
                        'dir d'
                    ]],
                    ['cd a', []],
                    ['ls', [
                        'dir e',
                        '29116 f',
                        '2557 g',
                        '62596 h.lst'
                    ]],
                    ['cd e', []],
                    ['ls', [
                        '584 i'
                    ]],
                    ['cd ..', []],
                    ['cd ..', []],
                    ['cd d', []],
                    ['ls', [
                        '4060174 j',
                        '8033020 d.log',
                        '5626152 d.ext',
                        '7214296 k'
                    ]]
                ]

                fs = part1.build_filesystem commands
                expect(fs).to eq ({
                    'a' => {
                        'e' => {
                            'i' => 584
                        },
                        'f' => 29116,
                        'g' => 2557,
                        'h.lst' => 62596
                    },
                    'b.txt' => 14848514,
                    'c.dat' => 8504156,
                    'd' => {
                        'd.ext' => 5626152,
                        'd.log' => 8033020,
                        'j' => 4060174,
                        'k' => 7214296
                    }
                })
            end

            it 'calculate the size of directories' do
                fs = {
                    'a' => {
                        'e' => {
                            'i' => 584
                        },
                        'f' => 29116,
                        'g' => 2557,
                        'h.lst' => 62596
                    },
                    'b.txt' => 14848514,
                    'c.dat' => 8504156,
                    'd' => {
                        'd.ext' => 5626152,
                        'd.log' => 8033020,
                        'j' => 4060174,
                        'k' => 7214296
                    }
                }

                dir_sizes = part1.dir_sizes fs
                expect(dir_sizes).to eq ({
                    Pathname.new('/a/e') => 584,
                    Pathname.new('/a') => 94853,
                    Pathname.new('/d') => 24933642,
                    Pathname.new('/') => 48381165
                })
            end
        end

        context "examples" do
            it 'matches the numbers in the example' do
                input = "$ cd /
$ ls
dir a
14848514 b.txt
8504156 c.dat
dir d
$ cd a
$ ls
dir e
29116 f
2557 g
62596 h.lst
$ cd e
$ ls
584 i
$ cd ..
$ cd ..
$ cd d
$ ls
4060174 j
8033020 d.log
5626152 d.ext
7214296 k".lines.map(&:chomp)

                result = part1.solve input
                expect(result).to eq 95437
            end
        end

        context "challenge" do
            it "finds the answer" do
                result = part1.solve
                expect(part1.solve).to eq 1513699
            end
        end
    end

    context 'Part 2' do
        context "examples" do
            it 'matches the numbers in the example' do
                input = "$ cd /
$ ls
dir a
14848514 b.txt
8504156 c.dat
dir d
$ cd a
$ ls
dir e
29116 f
2557 g
62596 h.lst
$ cd e
$ ls
584 i
$ cd ..
$ cd ..
$ cd d
$ ls
4060174 j
8033020 d.log
5626152 d.ext
7214296 k".lines.map(&:chomp)

                result = part2.solve input
                expect(result).to eq 24933642
            end
        end

        context "challenge" do
            it "finds the answer" do
                result = part2.solve
                expect(result).to eq 7991939
            end
        end
    end
end
