module Y2021
    module Day4
        module Part1
            def self.read_input
                File.read('2021/04/puzzle-input.txt').chomp
            end

            def self.parse_board raw_board
                lines = raw_board.split("\n")
                lines.map {|line| line.strip.split(" ").map(&:to_i)}
            end

            def self.parse_input raw
                splits = raw.split("\n\n")
                draws = splits[0].split(',').map(&:to_i)
                raw_boards = splits[1..]
                boards = raw_boards.map { |raw_board| self.parse_board raw_board }
                [draws, boards]
            end

            def self.check_rows board, sequence
                board.any? do |row|
                    row.all? { |cell| sequence.include? cell }
                end
            end

            def self.check_board board, sequence
                self.check_rows(board, sequence) || self.check_rows(board.transpose, sequence)
            end

            def self.find_winning_board boards, sequence
                for x in 0..sequence.count
                    partial_sequence = sequence[0..x]
                    winning_board = boards.find {|board| self.check_board board, partial_sequence.to_set}
                    unless winning_board.nil?
                        return winning_board, partial_sequence
                    end
                end
            end

            def self.calculate_score board, sequence
                remaining_values = board.flatten.filter {|value| !sequence.include? value}
                remaining_values.sum * sequence[-1]
            end
        end
    end
end