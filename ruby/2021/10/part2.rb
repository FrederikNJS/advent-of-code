module Y2021
    module Day10
        module Part2
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
                        return nil
                    end
                end
                stack.map{|char| brackets[char]}.reverse
            end

            def self.calculate_autocomplete_score completions
                char_scores = {
                    ')' => 1,
                    ']' => 2,
                    '}' => 3,
                    '>' => 4
                }
                completions.map do |completion|
                    score = 0
                    completion.each do |char|
                        score *= 5
                        score += char_scores[char]
                    end
                    score
                end
            end
        end
    end
end
