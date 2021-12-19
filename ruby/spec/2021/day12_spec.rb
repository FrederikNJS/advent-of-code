require 'immutable'
require_relative '../../2021/12/part1.rb'
require_relative '../../2021/12/part2.rb'
require 'pry'

RSpec.describe '2021 Day 12' do
    part1 = Y2021::Day12::Part1
    part2 = Y2021::Day12::Part2

    context 'Part 1' do
        context 'unit tests' do
            it 'can turn a list of adjacencies into a map' do
                raw = "start-A
start-b
A-c
A-b
b-d
A-end
b-end".lines.map(&:chomp)

                expect(part1.parse_input(raw)).to eq ({
                    "start" => Set["A","b"],
                    "A" => Set["b", "c","end"],
                    "c" => Set["A"],
                    "b" => Set["A","d","end"],
                    "d" => Set["b"]
                })
            end
        end

        context 'examples' do
            it 'matches the numbers in the first' do
                raw = "start-A
start-b
A-c
A-b
b-d
A-end
b-end".lines.map(&:chomp)
                path_map = part1.parse_input(raw)
                all_paths = part1.find_all_paths(path_map, "start", "end")
                expect(all_paths).to eq (Set[
                    Immutable::List["start","A","b","A","c","A","end"],
                    Immutable::List["start","A","b","A","end"],
                    Immutable::List["start","A","b","end"],
                    Immutable::List["start","A","c","A","b","A","end"],
                    Immutable::List["start","A","c","A","b","end"],
                    Immutable::List["start","A","c","A","end"],
                    Immutable::List["start","A","end"],
                    Immutable::List["start","b","A","c","A","end"],
                    Immutable::List["start","b","A","end"],
                    Immutable::List["start","b","end"]
                ])
                expect(all_paths.size).to eq 10
            end

            it 'matches the numbers in the second example' do
                raw = "dc-end
HN-start
start-kj
dc-start
dc-HN
LN-dc
HN-end
kj-sa
kj-HN
kj-dc".lines.map(&:chomp)

                path_map = part1.parse_input(raw)
                all_paths = part1.find_all_paths(path_map, "start", "end")
                expect(all_paths.size).to eq 19
            end

            it 'matches the numbers in the third example' do
                raw = "fs-end
he-DX
fs-he
start-DX
pj-DX
end-zg
zg-sl
zg-pj
pj-he
RW-he
fs-DX
pj-RW
zg-RW
start-pj
he-WI
zg-he
pj-fs
start-RW".lines.map(&:chomp)

                path_map = part1.parse_input(raw)
                all_paths = part1.find_all_paths(path_map, "start", "end")
                expect(all_paths.size).to eq 226
            end
        end

        context "challenge" do
            it "finds the answer" do
                raw = part1.read_input
                path_map = part1.parse_input(raw)
                all_paths = part1.find_all_paths(path_map, "start", "end")
                expect(all_paths.size).to eq 3679
            end
        end
    end

    context 'Part 2' do
        context 'unit tests' do

        end

        context "examples" do
            it 'matches the numbers in the example' do
                raw = "start-A
start-b
A-c
A-b
b-d
A-end
b-end".lines.map(&:chomp)
                path_map = part1.parse_input(raw)
                all_paths = part2.find_all_paths(path_map, "start", "end")
                expect(all_paths.size).to eq 36
            end
        end

        context "challenge" do
            it "finds the answer" do
                raw = part1.read_input
                path_map = part1.parse_input(raw)
                all_paths = part2.find_all_paths(path_map, "start", "end")
                expect(all_paths.size).to eq 107395
            end
        end
    end
end
