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

      def self.first_index_of_number line


      def self.substitute_text_numbers line
        new_line = line.dup
        @substitutions.each {|text, number| new_line.gsub! text, number }
        new_line
      end

      def self.solve input=nil
        input ||= @part1.read_input
        input.map do |line|
          new_line = self.substitute_text_numbers line
          @part1.extract_number new_line
        end.sum
      end
    end
  end
end
