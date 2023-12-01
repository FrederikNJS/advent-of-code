require_relative 'part1.rb'

module Y2023
  module Day1
    module Part2
      @part1 = Y2023::Day1::Part1

      @substitutions = {
        'one' => '1',
        'two' => '2',
        'three' => '3',
        'four' => '4',
        'five' => '5',
        'six' => '6',
        'seven' => '7',
        'eight' => '8',
        'nine' => '9',
        'zero' => '0'
      }

      @reversed_key_substitutions = @substitutions.map {|key, value| [key.reverse, value]}.to_h

      def self.first_number line
        @substitutions.map {|text, number| [number, [line.index(text) || 100, line.index(number) || 100].min] }.to_h.min_by {|number, index| index}[0]
      end

      def self.last_number line
        @reversed_key_substitutions.map {|text, number| [number, [line.reverse.index(text) || 100, line.reverse.index(number) || 100].min] }.to_h.min_by {|number, index| index}[0]
      end

      def self.solve input=nil
        input ||= @part1.read_input
        input.map do |line|
          (self.first_number(line) + self.last_number(line)).to_i
        end.sum
      end
    end
  end
end
