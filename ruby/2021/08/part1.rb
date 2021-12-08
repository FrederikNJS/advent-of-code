module Y2021
    module Day8
        module Part1
            def self.read_input
                File.readlines('2021/08/puzzle-input.txt').map(&:chomp)
            end

            def self.convert_seven_segment_display input_string
                input_string.map do |signal_pattern|
                    signal_pattern.chars.map do |char|
                        char.to_sym
                    end.to_set
                end
            end

            def self.parse_line line
                raw_unique_signal_pattern, raw_output_value = line.split(' | ')
                unique_signal_patterns = raw_unique_signal_pattern.split(' ')
                output_values = raw_output_value.split(' ')
                {
                    unique_signal_pattern: self.convert_seven_segment_display(unique_signal_patterns),
                    output_value: self.convert_seven_segment_display(output_values)
                }
            end

            def self.parse_input input
                input.map { |line| self.parse_line line }
            end

            def self.count_unique_digits input
                unique_digits = Set[2,3,4,7]
                input.sum do |row|
                    row[:output_value].map { |digit| digit.size }.count {|digit| unique_digits.include? digit}
                end
            end
        end
    end
end
