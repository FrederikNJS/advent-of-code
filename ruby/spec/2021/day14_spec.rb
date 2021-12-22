require 'immutable'
require_relative '../../2021/14/part1.rb'
require_relative '../../2021/14/part2.rb'
require 'pry'

RSpec.describe '2021 Day 14' do
    part1 = Y2021::Day14::Part1
    part2 = Y2021::Day14::Part2

    context 'Part 1' do
        context 'unit tests' do
            it 'can simulate a polymer step' do
                raw = "NNCB

CH -> B
HH -> N
CB -> H
NH -> C
HB -> C
HC -> B
HN -> C
NN -> C
BH -> H
NC -> B
NB -> B
BN -> B
BB -> N
BC -> B
CC -> N
CN -> C"

                initial_template, rules = part1.parse_input raw
                new_template = part1.polymer_step initial_template.chars, rules
                expect(new_template).to eq ['N','C','N','B','C','H','B']
            end
        end

        context 'examples' do
            it 'matches the numbers in the first example' do
                raw = "NNCB

CH -> B
HH -> N
CB -> H
NH -> C
HB -> C
HC -> B
HN -> C
NN -> C
BH -> H
NC -> B
NB -> B
BN -> B
BB -> N
BC -> B
CC -> N
CN -> C"

                initial_template, rules = part1.parse_input raw
                new_template = part1.simulate_n_polymer_steps 4, initial_template.chars, rules
                expect(new_template.join).to eq "NBBNBNBBCCNBCNCCNBBNBBNBBBNBBNBBCBHCBHHNHCBBCBHCB"
                new_template2 = part1.simulate_n_polymer_steps 10, initial_template.chars, rules
                expect(part1.polymer_tension new_template2).to eq 1588
            end
        end

        context "challenge" do
            it "finds the answer" do
                raw = part1.read_input
                initial_template, rules = part1.parse_input raw
                new_template = part1.simulate_n_polymer_steps 10, initial_template.chars, rules
                expect(part1.polymer_tension new_template).to eq 2937
            end
        end
    end

    context 'Part 2' do
        context 'unit tests' do
            it 'can count characters and pairs' do
                character_counts, pair_counts = part2.counts "NNCB"
                expect(character_counts).to eq ({
                    'N' => 2,
                    'C' => 1,
                    'B' => 1
                })
                expect(pair_counts).to eq ({
                    'NN' => 1,
                    'NC' => 1,
                    'CB' => 1
                })
            end

            it 'can update counts' do
                raw = "NNCB

CH -> B
HH -> N
CB -> H
NH -> C
HB -> C
HC -> B
HN -> C
NN -> C
BH -> H
NC -> B
NB -> B
BN -> B
BB -> N
BC -> B
CC -> N
CN -> C"

                initial_template, rules = part1.parse_input raw
                character_counts, pair_counts = part2.counts initial_template
                new_character_counts, new_pair_counts = part2.polymer_count_step character_counts, pair_counts, rules
                expect(new_character_counts).to eq ({
                    'N' => 2,
                    'C' => 2,
                    'B' => 2,
                    'H' => 1
                })
            end
        end

        context "examples" do
            it 'matches the numbers in the example' do
                raw = "NNCB

CH -> B
HH -> N
CB -> H
NH -> C
HB -> C
HC -> B
HN -> C
NN -> C
BH -> H
NC -> B
NB -> B
BN -> B
BB -> N
BC -> B
CC -> N
CN -> C"

                initial_template, rules = part1.parse_input raw
                character_counts, pair_counts = part2.counts initial_template
                new_character_counts, new_pair_counts = part2.polymer_counter 10, character_counts, pair_counts, rules
                expect(part2.polymer_tension new_character_counts).to eq 1588
            end

            it 'matches the numbers in the second example' do
                raw = "NNCB

CH -> B
HH -> N
CB -> H
NH -> C
HB -> C
HC -> B
HN -> C
NN -> C
BH -> H
NC -> B
NB -> B
BN -> B
BB -> N
BC -> B
CC -> N
CN -> C"

                initial_template, rules = part1.parse_input raw
                character_counts, pair_counts = part2.counts initial_template
                new_character_counts, new_pair_counts = part2.polymer_counter 40, character_counts, pair_counts, rules
                expect(part2.polymer_tension new_character_counts).to eq 2188189693529
            end
        end

        context "challenge" do
            it "finds the answer" do
                raw = part1.read_input
                initial_template, rules = part1.parse_input raw
                character_counts, pair_counts = part2.counts initial_template
                new_character_counts, new_pair_counts = part2.polymer_counter 40, character_counts, pair_counts, rules
                expect(part2.polymer_tension new_character_counts).to eq 3390034818249
            end
        end
    end
end

