module Y2021
    module Day5
        module Part1
            def self.read_input
                File.readlines('2021/05/puzzle-input.txt').map(&:chomp)
            end

            def self.parse_input raw_input
                raw_input.map do |line|
                    from, to = line.split(' -> ')
                    x1, y1 = from.split(',')
                    x2, y2 = to.split(',')
                    {
                        from: {
                            x: x1.to_i,
                            y: y1.to_i
                        },
                        to: {
                            x: x2.to_i,
                            y: y2.to_i
                        }
                    }
                end
            end

            def self.filter_lines lines
                lines.filter { |line| line[:from][:x] == line[:to][:x] || line[:from][:y] == line[:to][:y] }
            end
            
            def self.make_sea_floor lines
                sea_floor = Hash.new(0)

                lines.each do |line|
                    if line[:from][:x] != line[:to][:x]
                        min, max = [line[:from][:x], line[:to][:x]].minmax
                        for x in min..max
                            sea_floor[[x, line[:from][:y]]] += 1
                        end
                    else
                        min, max = [line[:from][:y], line[:to][:y]].minmax
                        for y in min..max
                            sea_floor[[line[:from][:x], y]] += 1
                        end
                    end
                end 
                sea_floor
            end

            def self.count_overlaps sea_floor
                sea_floor.count { |coord, value| value > 1 }
            end
        end
    end
end