require 'immutable'
require_relative '../../2021/16/part1.rb'
require_relative '../../2021/16/part2.rb'
require 'pry'

RSpec.describe '2021 Day 16' do
    part1 = Y2021::Day16::Part1
    part2 = Y2021::Day16::Part2

    context 'Part 1' do
        context 'unit tests' do
            it 'parses the input' do
                raw = "D2FE28"
                parsed = part1.parse_input(raw)
                expect(parsed).to eq '110100101111111000101000'
            end

            it 'parses another input' do
                raw = "38006F45291200"
                parsed = part1.parse_input(raw)
                expect(parsed).to eq '00111000000000000110111101000101001010010001001000000000'
            end

            it 'can parse a literal value' do
                raw = "D2FE28"
                parsed = part1.parse_input(raw)
                literal = part1.grok_packet parsed
                expect(literal.version).to eq 6
                expect(literal.type_id).to eq 4
                expect(literal.value).to eq 2021
            end

            it 'can parse a total length operator' do
                raw = "38006F45291200"
                parsed = part1.parse_input(raw)
                operator = part1.grok_packet parsed
                expect(operator.version).to eq 1
                expect(operator.type_id).to eq 6
                expect(operator.length_type).to eq 0
                expect(operator.subpackets.size).to eq 2
                expect(operator.subpackets[0].value).to eq 10
                expect(operator.subpackets[1].value).to eq 20
            end

            it 'can parse a packet count operator' do
                raw = "EE00D40C823060"
                parsed = part1.parse_input(raw)
                operator = part1.grok_packet parsed
                expect(operator.version).to eq 7
                expect(operator.type_id).to eq 3
                expect(operator.length_type).to eq 1
                expect(operator.subpackets.size).to eq 3
                expect(operator.subpackets[0].value).to eq 1
                expect(operator.subpackets[1].value).to eq 2
                expect(operator.subpackets[2].value).to eq 3
            end
        end

        context 'examples' do
            it 'matches the numbers in the first example' do
                raw = "8A004A801A8002F478"
                parsed = part1.parse_input(raw)
                packet = part1.grok_packet parsed
                expect(packet.version_sum).to eq 16
            end

            it 'matches the numbers in the second example' do
                raw = "620080001611562C8802118E34"
                parsed = part1.parse_input(raw)
                packet = part1.grok_packet parsed
                expect(packet.version_sum).to eq 12
            end

            it 'matches the numbers in the third example' do
                raw = "C0015000016115A2E0802F182340"
                parsed = part1.parse_input(raw)
                packet = part1.grok_packet parsed
                expect(packet.version_sum).to eq 23
            end

            it 'matches the numbers in the fourth example' do
                raw = "A0016C880162017C3686B18A3D4780"
                parsed = part1.parse_input(raw)
                packet = part1.grok_packet parsed
                expect(packet.version_sum).to eq 31
            end
        end

        context "challenge" do
            it "finds the answer" do
                raw = part1.read_input
                parsed = part1.parse_input(raw)
                packet = part1.grok_packet parsed
                expect(packet.version_sum).to eq 979
            end
        end
    end

    context 'Part 2' do
        context 'unit tests' do
            it 'can extend the grid' do

            end
        end

        context "examples" do
            it 'matches the numbers in the first example' do
                raw = "C200B40A82"
                parsed = part1.parse_input(raw)
                packet = part1.grok_packet parsed
                expect(packet.value).to eq 3
            end

            it 'matches the numbers in the second example' do
                raw = "04005AC33890"
                parsed = part1.parse_input(raw)
                packet = part1.grok_packet parsed
                expect(packet.value).to eq 54
            end
        end

        context "challenge" do
            it "finds the answer" do
                raw = part1.read_input
                parsed = part1.parse_input(raw)
                packet = part1.grok_packet parsed
                expect(packet.value).to eq 277110354175
            end
        end
    end
end

