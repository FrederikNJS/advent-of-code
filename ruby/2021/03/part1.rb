module Y2021
    module Day3
        module Part1
            def self.read_input
                File.readlines('2021/03/puzzle-input.txt').map(&:chomp)
            end

            def self.parse_input raw_input
                raw_input.map {|str| str.to_i(2)}
            end

            def self.bitwise_not value, digits
                value.to_s(2).rjust(digits, '0').gsub('1', '2').gsub('0', '1').gsub('2', '0').to_i(2)
            end

            def self.calculate_diagnostics input, digits
                gamma_rate = 0
                for x in 0...digits
                    mask = 1 << x
                    on_bits = input.map { |d| (d & mask) > 0 }.count { |b| b }
                    if on_bits >= input.count / 2.0
                        gamma_rate |= mask
                    end
                end
                epsilon_rate = self.bitwise_not gamma_rate, digits
                [gamma_rate, epsilon_rate]
            end
        end
    end
end