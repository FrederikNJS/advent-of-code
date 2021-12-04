require_relative '../../../2021/04/part1.rb'

RSpec.describe "2021/04/Part1" do
    part1 = Y2021::Day4::Part1

    context "unit tests" do
        it 'parses a board' do
            raw_board = "22 13 17 11  0
 8  2 23  4 24
21  9 14 16  7
 6 10  3 18  5
 1 12 20 15 19"
            expect(part1.parse_board raw_board).to eq [
                [22,13,17,11,0],
                [8,2,23,4,24],
                [21,9,14,16,7],
                [6,10,3,18,5],
                [1,12,20,15,19]
            ]
        end

        it 'read input' do
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

            expected = [
                [7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1],
                [
                    [
                        [22,13,17,11,0],
                        [8,2,23,4,24],
                        [21,9,14,16,7],
                        [6,10,3,18,5],
                        [1,12,20,15,19]
                    ],
                    [
                        [3,15,0,2,22],
                        [9,18,13,17,5],
                        [19,8,7,25,23],
                        [20,11,10,24,4],
                        [14,21,16,12,6]
                    ],
                    [
                        [14,21,17,24,4],
                        [10,16,15,9,19],
                        [18,8,23,26,20],
                        [22,11,13,6,5],
                        [2,0,12,3,7]
                    ]
                ]
            ]

            expect(part1.parse_input raw).to eq(expected)
        end
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
            winning_board, winning_sequence = part1.find_winning_board input[1], input[0]
            expect(winning_board).to eq [
                [14,21,17,24,4],
                [10,16,15,9,19],
                [18,8,23,26,20],
                [22,11,13,6,5],
                [2,0,12,3,7]
            ]
            expect(winning_sequence).to eq [7,4,9,5,11,17,23,2,0,14,21,24]
            score = part1.calculate_score(winning_board, winning_sequence)
            expect(score).to eq 4512
        end
    end

    context "challenge" do
        it "finds the answer" do
            raw = part1.read_input
            input = part1.parse_input raw
            winning_board, winning_sequence = part1.find_winning_board input[1], input[0]
            expect(winning_board).to eq [
                [7, 70, 5, 69, 4],
                [34, 60, 40, 73, 6],
                [74, 54, 67, 32, 38],
                [93, 62, 17, 51, 86],
                [57, 88, 99, 3, 16]
            ]
            expect(winning_sequence).to eq [27, 14, 70, 7, 85, 66, 65, 57, 68, 23, 33, 78, 4, 84, 25, 18, 43, 71, 76, 61, 34, 82, 93, 74]
            score = part1.calculate_score(winning_board, winning_sequence)
            expect(score).to eq 64084
        end
    end
end
