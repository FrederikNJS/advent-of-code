module Y2023
  module Day1
    module Part1
      def self.read_input
        File.readlines('2023/01/puzzle-input.txt').map(&:chomp)
      end

      def self.extract_number input
        input.scan(/\d/).values_at(0, -1).join('').to_i
      end

      def self.get_all_numbers input
        input.map { |line| self.extract_number line }
      end

      def self.partial_solve input=nil
        input ||= self.read_input
        numbers = self.get_all_numbers input[0...10]
      end

      def self.solve input=nil
        input ||= self.read_input
        numbers = self.get_all_numbers input
        numbers.sum
      end
    end
  end
end
