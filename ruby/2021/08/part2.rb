module Y2021
    module Day8
        module Part2
            def self.count_segment_frequency unique_signal_pattern
                segments = [:a, :b, :c, :d, :e, :f, :g]
                segment_frequencies = segments.map do |segment|
                    [segment, unique_signal_pattern.count { |segments| segments.include? segment }]
                end.to_h
            end

            def self.identify_digits unique_signal_pattern
                unique_digit_lengths = {
                    1 => 2,
                    7 => 3,
                    4 => 4,
                    8 => 7
                }

                identified_digits = unique_digit_lengths.map do |digit, length|
                    [digit, unique_signal_pattern.find { |pattern| pattern.size == length }]
                end.to_h

                identified_digits[3] = unique_signal_pattern.find { |pattern| pattern.size == 5 && pattern & identified_digits[1] == identified_digits[1] }
                identified_digits[9] = identified_digits[3] | identified_digits[4]

                segment_frequencies = self.count_segment_frequency unique_signal_pattern
                lower_left_segment = segment_frequencies.find { |segment, count| count == 4 }[0]
                upper_left_segment = segment_frequencies.find { |segment, count| count == 6 }[0]
                lower_right_segment = segment_frequencies.find { |segment, count| count == 9 }[0]

                identified_digits[2] = unique_signal_pattern.find { |pattern| pattern.size == 5 && pattern.include?(lower_left_segment) }
                identified_digits[5] = unique_signal_pattern.find { |pattern| pattern.size == 5 && pattern != identified_digits[2] && pattern != identified_digits[3] }

                upper_right_segment = (identified_digits[2] & identified_digits[4] & identified_digits[7]).to_a[0]

                identified_digits[6] = unique_signal_pattern.find { |pattern| pattern.size == 6 && !pattern.include?(upper_right_segment)}
                identified_digits[0] = unique_signal_pattern.find { |pattern| pattern.size == 6 && pattern != identified_digits[6] && pattern != identified_digits[9] }

                identified_digits.map { |digit, set| [set, digit] }.to_h
            end

            def self.convert_display_to_digit displays, identified_digits
                displays.map { |display| identified_digits[display].to_s }.join.to_i
            end
        end
    end
end
