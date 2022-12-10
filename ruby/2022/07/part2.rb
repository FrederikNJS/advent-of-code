require_relative 'part1.rb'

module Y2022
    module Day7
        module Part2
            @part1 = Y2022::Day7::Part1

            def self.solve input=nil
                input = @part1.read_input unless input
                commands = @part1.split_commands input
                fs = @part1.build_filesystem commands
                sizes = @part1.dir_sizes fs

                total_disk_size = 70000000
                target_free = 30000000
                current_used = sizes[Pathname.new('/')]
                current_free = total_disk_size - current_used
                to_free = target_free - current_free

                candidates = sizes.filter{|path, size| size >= to_free}

                candidates.min_by {|path, size| size}[1]
            end
        end
    end
end
