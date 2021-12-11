require_relative '../../2021/10/part1.rb'
require_relative '../../2021/10/part2.rb'
require 'pry'

RSpec.describe '2021 Day 10' do
    part1 = Y2021::Day10::Part1
    part2 = Y2021::Day10::Part2

    context 'Part 1' do
        context 'unit tests' do
            it 'can find a syntax error' do
                valid = '[<>({}){}[([])<>]]'.chars
                expect(part1.find_syntax_error valid).to be nil
                invalid = '{([(<{}[<>[]}>{[]{[(<()>'.chars
                expect(part1.find_syntax_error invalid).to eq '}'
            end
        end

        context 'examples' do
            it 'matches the numbers in the first example' do
                raw_example = '[({(<(())[]>[[{[]{<()<>>
[(()[<>])]({[<{<<[]>>(
{([(<{}[<>[]}>{[]{[(<()>
(((({<>}<{<{<>}{[]{[]{}
[[<[([]))<([[{}[[()]]]
[{[{({}]{}}([{[{{{}}([]
{<[[]]>}<{[{[{[]{()[[[]
[<(<(<(<{}))><([]([]()
<{([([[(<>()){}]>(<<{{
<{([{{}}[<[[[<>{}]]]>[]]'.lines.map(&:chomp)

                input = part1.parse_input raw_example
                score = part1.score_syntax_errors input
                expect(score).to eq 26397
            end
        end

        context "challenge" do
            it "finds the answer" do
                raw = part1.read_input
                input = part1.parse_input raw
                score = part1.score_syntax_errors input
                expect(score).to eq 387363
            end
        end
    end

    context 'Part 2' do
        context 'unit tests' do
            it 'can "autocomplete" the syntax' do
                valid = '[({(<(())[]>[[{[]{<()<>>'.chars
                stack = part2.find_syntax_error valid
                expect(stack).to eq '}}]])})]'.split("")
            end
        end

        context "examples" do
            it 'matches the numbers in the example' do
                raw_example = '[({(<(())[]>[[{[]{<()<>>
[(()[<>])]({[<{<<[]>>(
{([(<{}[<>[]}>{[]{[(<()>
(((({<>}<{<{<>}{[]{[]{}
[[<[([]))<([[{}[[()]]]
[{[{({}]{}}([{[{{{}}([]
{<[[]]>}<{[{[{[]{()[[[]
[<(<(<(<{}))><([]([]()
<{([([[(<>()){}]>(<<{{
<{([{{}}[<[[[<>{}]]]>[]]'.lines.map(&:chomp)
                input = part1.parse_input raw_example
                autocompletions = input.map{|line|part2.find_syntax_error line}.filter{|autocompletion| !autocompletion.nil?}
                scores = part2.calculate_autocomplete_score autocompletions
                expect(scores).to eq [
                    288957,
                    5566,
                    1480781,
                    995444,
                    294
                ]
                winning_score = scores.sort[scores.size / 2]
                expect(winning_score).to eq 288957
            end
        end

        context "challenge" do
            it "finds the answer" do
                raw = part1.read_input
                input = part1.parse_input raw
                autocompletions = input.map{|line|part2.find_syntax_error line}.filter{|autocompletion| !autocompletion.nil?}
                scores = part2.calculate_autocomplete_score autocompletions
                winning_score = scores.sort[scores.size / 2]
                expect(winning_score).to eq 288957
            end
        end
    end
end
