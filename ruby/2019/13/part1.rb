require_relative '../11/part1.rb'
require 'logger'
require 'pry'

if __FILE__ == $0
    input = File.read('2019/13/puzzle-input.txt')
    program = input.chomp.split(',').map { |string_ops| string_ops.to_i }

    inputs = Queue.new
    outputs = Queue.new

    process_program111(program, inputs, outputs)

    output_array = []
    until outputs.empty?
        output_array << outputs.pop
    end

    wall = "██"
    block = "▒▒"
    paddle = "▀▀"
    ball = "⬤ "

    puts " ██ = Wall"
    puts " ▒▒ = Block"
    puts " ▀▀ = Paddle"
    puts " ⬤  = Ball"

    tiles = []

    output_array.each_slice(3) do |chunk|
        tiles << chunk
    end

    max_x = tiles.max_by { |tile| tile[0]}[0]
    max_y = tiles.max_by { |tile| tile[1]}[1]
    puts max_x
    puts max_y
    screen = Array.new(max_y+1) {|row| Array.new(max_x+1) {|column| " "}}

    tiles.each do |tile|
        case tile[2]
        when 0
            screen[tile[1]][tile[0]] = "  "
        when 1
            screen[tile[1]][tile[0]] = "██"
        when 2
            screen[tile[1]][tile[0]] = "▒▒"
        when 3
            screen[tile[1]][tile[0]] = "▀▀"
        when 4
            screen[tile[1]][tile[0]] = "⬤ "
        else
            raise Exception.new("Invalid tile")
        end
    end

    screen.each do |row|
        puts row.join
    end

    puts screen.map {|row| row.count "▒▒"}.sum
end
