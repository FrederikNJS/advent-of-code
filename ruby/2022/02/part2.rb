require_relative 'part1.rb'

module Y2022
    module Day2
        module Part2
            @part1 = Y2022::Day2::Part1


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

            def self.solve input=nil
                input = @part1.read_input unless input
                guide = self.parse_input input
                self.calculate_guide guide
            end
        end
    end
end
