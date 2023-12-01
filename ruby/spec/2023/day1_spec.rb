require_relative '../../2023/01/part1.rb'
require_relative '../../2023/01/part2.rb'

RSpec.describe "2023 Day 1" do
  part1 = Y2023::Day1::Part1
  part2 = Y2023::Day1::Part2

  context 'Part 1' do
    context "unit tests" do
      it 'can find the first and last numbers of a line' do
        input = [
          '1abc2',
          'pqr3stu8vwx',
          'a1b2c3d4e5f',
          'treb7uchet'
        ]

        expect(part1.extract_number input[0]).to eq 12
        expect(part1.extract_number input[1]).to eq 38
        expect(part1.extract_number input[2]).to eq 15
        expect(part1.extract_number input[3]).to eq 77
      end
    end

    context "examples" do
      it 'matches the numbers in the example' do
        input = '1abc2
pqr3stu8vwx
a1b2c3d4e5f
treb7uchet'.lines

        expect(part1.solve input).to eq 142
      end
    end

    context "partial challenge" do
      it "finds the partial answer" do
        expect(part1.partial_solve).to eq [
          33,
          78,
          57,
          33,
          99,
          99,
          53,
          99,
          54,
          11
        ]
      end
    end

    context "challenge" do
      it "finds the answer" do
        expect(part1.solve).to be < 891615807502
        expect(part1.solve).to eq 55002
      end
    end
  end

  context 'Part 2' do
    context "examples" do
      it 'can find the first number' do
        input = [
          'two1nine',
          'eightwothree',
          'abcone2threexyz',
          'xtwone3four',
          '4nineeightseven2',
          'zoneight234',
          '7pqrstsixteen'
        ]

        expect(part2.first_number input[0]).to eq '2'
        expect(part2.first_number input[1]).to eq '8'
        expect(part2.first_number input[2]).to eq '1'
        expect(part2.first_number input[3]).to eq '2'
        expect(part2.first_number input[4]).to eq '4'
        expect(part2.first_number input[5]).to eq '1'
        expect(part2.first_number input[6]).to eq '7'
      end

      it 'can find the last number' do
        input = [
          'two1nine',
          'eightwothree',
          'abcone2threexyz',
          'xtwone3four',
          '4nineeightseven2',
          'zoneight234',
          '7pqrstsixteen'
        ]

        expect(part2.last_number input[0]).to eq '9'
        expect(part2.last_number input[1]).to eq '3'
        expect(part2.last_number input[2]).to eq '3'
        expect(part2.last_number input[3]).to eq '4'
        expect(part2.last_number input[4]).to eq '2'
        expect(part2.last_number input[5]).to eq '4'
        expect(part2.last_number input[6]).to eq '6'
      end

      it 'matches the numbers in the example' do
        input = 'two1nine
eightwothree
abcone2threexyz
xtwone3four
4nineeightseven2
zoneight234
7pqrstsixteen'.lines

        expect(part2.solve input).to eq 281
      end
    end

    context "challenge" do
      it "finds the answer" do
        expect(part2.solve).to eq 55093
      end
    end
  end
end
