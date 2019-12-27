require_relative '../11/part1.rb'
require 'logger'
require 'pry'

if __FILE__ == $0
    input = File.read('2019/13/puzzle-input.txt')
    program = input.chomp.split(',').map { |string_ops| string_ops.to_i }
    program[0] = 2
    inputs = Queue.new
    outputs = Queue.new

    ready_for_input = Queue.new
    thread = Thread.new {
        process_program111(program, inputs, outputs, ready_for_input)
    }

    empty = "  "
    wall = "██"
    block = "▒▒"
    paddle = "▀▀"
    ball = "⬤ "

    puts " ██ = Wall"
    puts " ▒▒ = Block"
    puts " ▀▀ = Paddle"
    puts " ⬤  = Ball"

    paddle_location = nil
    score = nil
    block_counter = 320
    screen = Array.new(21) {|row| Array.new(38) {|column| " "}}

    while thread.alive? || !outputs.empty?
        ready = ready_for_input.pop
        output_array = []
        until outputs.empty?
            output_array << outputs.pop
        end
        tiles = []

        ball_location = nil
        output_array.each_slice(3) do |chunk|
            if chunk[0] == -1 && chunk[1] == 0
                if chunk[2] != score
                    block_counter -= 1
                end
                score = chunk[2]
            else
                if chunk[2] == 4
                    ball_location = [chunk[0], chunk[1]]
                elsif chunk[2] == 3
                    paddle_location = [chunk[0], chunk[1]]
                end
                tiles << chunk
            end
        end


        tiles.each do |tile|
            case tile[2]
            when 0
                screen[tile[1]][tile[0]] = empty
            when 1
                screen[tile[1]][tile[0]] = wall
            when 2
                screen[tile[1]][tile[0]] = block
            when 3
                screen[tile[1]][tile[0]] = paddle
            when 4
                screen[tile[1]][tile[0]] = ball
            else
                raise Exception.new("Invalid tile")
            end
        end

        screen.each do |row|
            puts row.join
        end

        puts "Score: #{score}"


        if ready == true
            #binding.pry
            inputs << (ball_location[0] <=> paddle_location[0])
        end
    end
    puts score
end
