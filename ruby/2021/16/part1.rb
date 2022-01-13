require 'immutable'
require 'pry'

module Y2021
    module Day16
        module Part1
            def self.read_input
                File.read('2021/16/puzzle-input.txt').chomp
            end

            def self.parse_input raw
                binary_string = raw.to_i(16).to_s(2)
                "0" * (raw.size * 4 - binary_string.size) + binary_string
            end

            class Packet
                attr_reader :version, :type_id, :bit_length

                def initialize(input)
                    @version = input[0..2].to_i(2)
                    @type_id = input[3..5].to_i(2)
                    @bit_length = 6
                end
            end

            class Literal < Packet
                attr_reader :value

                def initialize(input)
                    super
                    rest = input[6..].chars
                    temp_val = ""
                    loop do
                        item = rest.shift 5
                        @bit_length += 5
                        temp_val << item[1..].join
                        break if item[0] == '0'
                    end

                    @value = temp_val.to_i(2)
                end

                def version_sum
                    @version
                end
            end

            class Operator < Packet
                attr_reader :length_type, :subpackets

                def initialize(input)
                    super
                    @length_type = input[6].to_i(2)
                    @subpackets = []
                    case @length_type
                    when 0
                        @bit_length += 16
                        subpacket_total_length = input[8...22].to_i(2)
                        raw_subpackets = input[22...(22 + subpacket_total_length)]
                        while raw_subpackets && raw_subpackets.length > 10
                            case raw_subpackets[3..5]
                            when '100' # ID 4, literal
                                packet = Literal.new(raw_subpackets)
                            else #operator
                                packet = Operator.new(raw_subpackets)
                            end
                            raw_subpackets = raw_subpackets[packet.bit_length..]
                            @bit_length += packet.bit_length
                            @subpackets << packet
                        end
                    when 1
                        @bit_length += 12
                        number_of_subpackets = input[8...18].to_i(2)
                        raw_subpackets = input[18..]
                        number_of_subpackets.times do
                            case raw_subpackets[3..5]
                            when '100' # ID 4, literal
                                packet = Literal.new(raw_subpackets)
                            else #operator
                                packet = Operator.new(raw_subpackets)
                            end
                            raw_subpackets = raw_subpackets[packet.bit_length..]
                            @bit_length += packet.bit_length
                            @subpackets << packet
                        end
                    end
                end

                def version_sum
                    @version + @subpackets.map{|packet| packet.version_sum}.sum
                end

                def value
                    case @type_id
                    when 0 #sum
                        @subpackets.map{|packet| packet.value}.flatten.sum
                    when 1 #product
                        @subpackets.map{|packet| packet.value}.flatten.reduce(:*)
                    when 2 #minimum
                        @subpackets.map{|packet| packet.value}.flatten.min
                    when 3 #maximum
                        @subpackets.map{|packet| packet.value}.flatten.max
                    when 5 #greater than
                        @subpackets[0].value > @subpackets[1].value ? 1 : 0
                    when 6 #less than
                        @subpackets[0].value < @subpackets[1].value ? 1 : 0
                    when 7 #equal to
                        @subpackets[0].value == @subpackets[1].value ? 1 : 0
                    end
                end
            end

            def self.grok_packet input
                type = input[3..5]
                case type
                when '100' # ID 4, literal
                    Literal.new(input)
                else #operator
                    Operator.new(input)
                end
            end
        end
    end
end
