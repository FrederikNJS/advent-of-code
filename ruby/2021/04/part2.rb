require_relative 'part1'

module Y2021
    module Day4
        module Part2
            def self.find_last_remaining_board boards, sequence
                for x in 0..sequence.count
                    partial_sequence = sequence[..-x]
                    remaining = boards.filter{|board| !Y2021::Day4::Part1.check_board board, partial_sequence}
                    if remaining.count == 1
                        return [remaining[0], sequence[..-(x-1)]]
                    end
                end
            end
        end
    end
end