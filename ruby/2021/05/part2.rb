require 'pry'
module Y2021
    module Day5
        module Part2
            def self.make_range from, to, count
                if from > to
                    from.downto(to)
                elsif from == to
                    [from].cycle(count+1)
                else
                    from..to
                end
            end

            def self.make_sea_floor lines
                sea_floor = Hash.new(0)

                lines.each do |line|
                    x_diff = (line[:from][:x] - line[:to][:x]).abs
                    y_diff = (line[:from][:y] - line[:to][:y]).abs
                    count = [x_diff, y_diff].max
                    coords = self.make_range(line[:from][:x], line[:to][:x], count).zip(self.make_range(line[:from][:y], line[:to][:y], count))
                    coords.each { |x, y| sea_floor[[x, y]] += 1 }
                end 

                sea_floor
            end
        end
    end
end