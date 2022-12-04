module Y2022
    module Day2
        module Part1
            @symbol_lut = {
                A: :rock,
                B: :paper,
                C: :scissors,
                X: :rock,
                Y: :paper,
                Z: :scissors
            }

            def self.read_input
                File.readlines('2022/02/puzzle-input.txt').map(&:chomp)
            end

            def self.parse_input lines
                lines.map {|line| line.split(' ').map{|a| @symbol_lut[a.to_sym]}}
            end

            def self.calculate_game_score opponent_play, i_play
                if opponent_play == :rock
                    if i_play == :rock
                        1 + 3
                    elsif i_play == :paper
                        2 + 6
                    elsif i_play == :scissors
                        3 + 0
                    end
                elsif opponent_play == :paper
                    if i_play == :rock
                        1 + 0
                    elsif i_play == :paper
                        2 + 3
                    elsif i_play == :scissors
                        3 + 6
                    end
                elsif opponent_play == :scissors
                    if i_play == :rock
                        1 + 6
                    elsif i_play == :paper
                        2 + 0
                    elsif i_play == :scissors
                        3 + 3
                    end
                end
            end

            def self.calculate_guide guide
                guide.map {|game| self.calculate_game_score(*game)}.sum
            end

            def self.solve input=nil
                input = self.read_input unless input
                guide = self.parse_input input
                self.calculate_guide guide
            end
        end
    end
end
