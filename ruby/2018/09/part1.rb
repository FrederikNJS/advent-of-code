require 'pry'

class Node
  attr_accessor :clockwise, :counter_clockwise
  attr_reader :value
  def initialize(value)
    @value = value
  end

  def detach
    @clockwise.counter_clockwise = @counter_clockwise
    @counter_clockwise.clockwise = @clockwise
    @clockwise = nil
    @counter_clockwise = nil
  end
end

class Ring
  def initialize
    @current = Node.new(0)
    @current.clockwise = @current
    @current.counter_clockwise = @current
    @highest_marble_played = 0
  end

  def remove_marble
    six_counter_clockwise = @current.counter_clockwise
                                    .counter_clockwise
                                    .counter_clockwise
                                    .counter_clockwise
                                    .counter_clockwise
                                    .counter_clockwise
    @current = six_counter_clockwise

    seven_counter_clockwise = six_counter_clockwise.counter_clockwise
    seven_counter_clockwise.detach
    seven_counter_clockwise
  end

  def insert_marble
    @highest_marble_played += 1
    new_marble = Node.new(@highest_marble_played)

    return [new_marble, remove_marble] if (new_marble.value % 23).zero?

    marble1 = @current.clockwise
    marble2 = @current.clockwise.clockwise

    marble1.clockwise = new_marble
    new_marble.counter_clockwise = marble1

    marble2.counter_clockwise = new_marble
    new_marble.clockwise = marble2

    @current = new_marble
    nil
  end
end

class Player
  attr_accessor :marbles_won
  def initialize
    @marbles_won = []
  end
end

def run
  ring = Ring.new
  players = Array.new(476) { Player.new }
  turns = 71_657

  players.cycle.take(turns).each do |player|
    result = ring.insert_marble
    player.marbles_won += result unless result.nil?
  end

  scores = players.map { |player| player.marbles_won.sum(&:value) }

  puts "Winning Score is #{scores.max}"
end

run
