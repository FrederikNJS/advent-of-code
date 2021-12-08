require_relative '../../2021/08/part1.rb'
require_relative '../../2021/08/part2.rb'
require 'pry'

RSpec.describe '2021 Day 08' do
    part1 = Y2021::Day8::Part1
    part2 = Y2021::Day8::Part2

    context 'Part 1' do
        context 'unit tests' do
            it 'can parse a line' do
                line = 'acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab | cdfeb fcadb cdfeb cdbaf'
                expected = {
                    unique_signal_pattern: [
                        Set[:a,:c,:e,:d,:g,:f,:b],
                        Set[:c,:d,:f,:b,:e],
                        Set[:g,:c,:d,:f,:a],
                        Set[:f,:b,:c,:a,:d],
                        Set[:d,:a,:b],
                        Set[:c,:e,:f,:a,:b,:d],
                        Set[:c,:d,:f,:g,:e,:b],
                        Set[:e,:a,:f,:b],
                        Set[:c,:a,:g,:e,:d,:b],
                        Set[:a,:b]
                    ],
                    output_value: [
                        Set[:c,:d,:f,:e,:b],
                        Set[:f,:c,:a,:d,:b],
                        Set[:c,:d,:f,:e,:b],
                        Set[:c,:d,:b,:a,:f]
                    ]
                }
                expect(part1.parse_line line).to eq expected
            end
        end

        context 'examples' do
            it 'matches the numbers in the first example' do
                raw_input = "be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe
edbfga begcd cbg gc gcadebf fbgde acbgfd abcde gfcbed gfec | fcgedb cgb dgebacf gc
fgaebd cg bdaec gdafb agbcfd gdcbef bgcad gfac gcb cdgabef | cg cg fdcagb cbg
fbegcd cbd adcefb dageb afcb bc aefdc ecdab fgdeca fcdbega | efabcd cedba gadfec cb
aecbfdg fbg gf bafeg dbefa fcge gcbea fcaegb dgceab fcbdga | gecf egdcabf bgf bfgea
fgeab ca afcebg bdacfeg cfaedg gcfdb baec bfadeg bafgc acf | gebdcfa ecba ca fadegcb
dbcfg fgd bdegcaf fgec aegbdf ecdfab fbedc dacgb gdcebf gf | cefg dcbef fcge gbcadfe
bdfegc cbegaf gecbf dfcage bdacg ed bedf ced adcbefg gebcd | ed bcgafe cdgba cbgef
egadfb cdbfeg cegd fecab cgb gbdefca cg fgcdab egfdb bfceg | gbdfcae bgc cg cgb
gcafb gcf dcaebfg ecagb gf abcdeg gaef cafbge fdbac fegbdc | fgae cfgab fg bagce".lines
                parsed = part1.parse_input(raw_input)
                expect(part1.count_unique_digits parsed).to eq 26
            end
        end

        context "challenge" do
            it "finds the answer" do
                raw_input = part1.read_input
                parsed = part1.parse_input(raw_input)
                expect(part1.count_unique_digits parsed).to eq 247
            end
        end
    end

    context 'Part 2' do
        context 'unit tests' do
            it 'can count segments frequencies' do
                row = part1.parse_line "acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab | cdfeb fcadb cdfeb cdbaf"
                frequencies = part2.count_segment_frequency row[:unique_signal_pattern]
            end

            it 'identify digits' do
                row = part1.parse_line "acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab | cdfeb fcadb cdfeb cdbaf"
                identified_digits = part2.identify_digits row[:unique_signal_pattern]
                expected = {
                    Set[:c,:a,:g,:e,:d,:b] => 0,
                    Set[:a,:b] => 1,
                    Set[:g,:c,:d,:f,:a] => 2,
                    Set[:f,:b,:c,:a,:d] => 3,
                    Set[:e,:a,:f,:b] => 4,
                    Set[:c,:d,:f,:b,:e] => 5,
                    Set[:c,:d,:f,:g,:e,:b] => 6,
                    Set[:d,:a,:b] => 7,
                    Set[:a,:c,:e,:d,:g,:f,:b] => 8,
                    Set[:c,:e,:f,:a,:b,:d] => 9
                }
                expect(identified_digits).to eq expected
            end
        end

        context "examples" do
            it 'matches the numbers in the example' do
                row = part1.parse_line "acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab | cdfeb fcadb cdfeb cdbaf"
                identified_digits = part2.identify_digits row[:unique_signal_pattern]
                expect(part2.convert_display_to_digit row[:output_value], identified_digits).to eq 5353
            end
        end

        context "challenge" do
            it "finds the answer" do
                raw_input = part1.read_input
                parsed = part1.parse_input(raw_input)
                numbers = parsed.map do |row|
                    identified_digits = part2.identify_digits row[:unique_signal_pattern]
                    part2.convert_display_to_digit row[:output_value], identified_digits
                end
                expect(numbers.sum).to eq 933305
            end
        end
    end
end
