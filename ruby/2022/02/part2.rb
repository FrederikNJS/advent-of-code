module Y2022
    module Day2
        module Part2
            @symbol_lut = {
                A: :rock,
                B: :paper,
                C: :scissors,
                X: :lose,
                Y: :draw,
                Z: :win
            }

            def self.parse_input lines
                lines.map {|line| line.split(' ').map{|a| @symbol_lut[a.to_sym]}}
            end

            def self.calculate_game_score opponent_play, i_play
                if opponent_play == :rock
                    if i_play == :lose #scissor
                        3 + 0
                    elsif i_play == :draw #rock
                        1 + 3
                    elsif i_play == :win #paper
                        2 + 6
                    end
                elsif opponent_play == :paper
                    if i_play == :lose #rock
                        1 + 0
                    elsif i_play == :draw #paper
                        2 + 3
                    elsif i_play == :win #scissors
                        3 + 6
                    end
                elsif opponent_play == :scissors
                    if i_play == :lose #paper
                        2 + 0
                    elsif i_play == :draw #scissors
                        3 + 3
                    elsif i_play == :win #rock
                        1 + 6
                    end
                end
            end

            def self.calculate_guide guide
                guide.map {|game| self.calculate_game_score(*game)}.sum
            end
        end
    end
end
