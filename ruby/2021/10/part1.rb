require 'pry'

module Y2021
    module Day10
        module Part1
            def self.read_input
                File.readlines('2021/10/puzzle-input.txt').map(&:chomp)
            end

            def self.parse_input raw
                raw.map {|line| line.chars}
            end

            def self.find_syntax_error line
                brackets = {
                    '(' => ')',
                    '[' => ']',
                    '{' => '}',
                    '<' => '>'
                }
                chars = line.dup
                stack = []
                until chars.empty?
                    current = chars.shift
                    if brackets.has_key? current
                        stack << current
                    elsif brackets[stack[-1]] == current
                        stack.pop
                    else
                        return current
                    end
                end
                nil
            end

            def self.score_syntax_errors input
                score_table = {
                    ')' => 3,
                    ']' => 57,
                    '}' => 1197,
                    '>' => 25137
                }
                score_table.default = 0
                input.map { |line| self.find_syntax_error line}.map { |char| score_table[char] }.sum
            end
        end
    end
end
