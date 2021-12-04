require_relative '../../../2021/04/part1.rb'
require_relative '../../../2021/04/part2.rb'

RSpec.describe "2021/04/Part2" do
    part1 = Y2021::Day4::Part1
    part2 = Y2021::Day4::Part2

    context "unit tests" do
    end

    context "examples" do
        it 'matches the numbers in the example' do
            raw = "7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1

22 13 17 11  0
 8  2 23  4 24
21  9 14 16  7
 6 10  3 18  5
 1 12 20 15 19

 3 15  0  2 22
 9 18 13 17  5
19  8  7 25 23
20 11 10 24  4
14 21 16 12  6

14 21 17 24  4
10 16 15  9 19
18  8 23 26 20
22 11 13  6  5
 2  0 12  3  7"
            input = part1.parse_input raw
            last_remaining_board, winning_sequence = part2.find_last_remaining_board(input[1], input[0])
            expect(last_remaining_board).to eq [
                [3,15,0,2,22],
                [9,18,13,17,5],
                [19,8,7,25,23],
                [20,11,10,24,4],
                [14,21,16,12,6]
            ]
            score = part1.calculate_score(last_remaining_board, winning_sequence)
            expect(score).to eq 1924
        end
    end

    context "challenge" do
        it "finds the answer" do
            raw = part1.read_input
            input = part1.parse_input raw
            last_remaining_board, winning_sequence = part2.find_last_remaining_board(input[1], input[0])
            expect(last_remaining_board).to eq [
                [52, 31, 24, 68, 41],
                [48, 82, 19, 29, 65],
                [51, 91, 97, 39, 80],
                [3, 55, 43, 40, 38],
                [20, 89, 53, 45, 75]
            ]
            score = part1.calculate_score(last_remaining_board, winning_sequence)
            expect(score).to eq 12833
        end
    end
end
