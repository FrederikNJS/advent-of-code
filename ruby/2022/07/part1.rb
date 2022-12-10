require 'pry'
require 'json'

module Y2022
    module Day7
        module Part1
            def self.read_input
                File.readlines('2022/07/puzzle-input.txt').map(&:chomp)
            end

            def self.split_commands input
                command_output_pairs = []
                input.each do |el|
                    if el.start_with? '$ '
                        command_output_pairs.append [el[2..],[]]
                    else
                        command_output_pairs.last[1].append el
                    end
                end
                command_output_pairs
            end

            def self.build_filesystem commands
                fs = {}
                current_path = []

                commands.each do |command, output|
                    case command
                    when /cd \//
                        current_path = command[3..].split('/')
                    when /cd \.\./
                        current_path.pop
                    when /cd /
                        current_path.append(*command[3..].split('/'))
                    when /ls/
                        output.each do |out_line|
                            a, name = out_line.split(' ')
                            case a
                            when /dir/
                                if current_path.size == 0
                                    fs[name] = {}
                                else
                                    fs.dig(*current_path)[name] = {}
                                end
                            when /\d+/
                                if current_path.size == 0
                                    fs[name] = a.to_i
                                else
                                    fs.dig(*current_path)[name] = a.to_i
                                end
                            end
                        end
                    end
                end
                fs
            end

            def self.dir_sizes fs, current_path=Pathname.new('/')
                computed_sizes = {}
                sum = fs.sum do |key, value|
                    if value.is_a? Numeric
                        value
                    else
                        computed_sizes.merge!(self.dir_sizes(value, current_path.join(key)))
                        computed_sizes[current_path.join(key)]
                    end
                end
                computed_sizes[current_path] = sum
                computed_sizes
            end

            def self.solve input=nil
                input = self.read_input unless input
                commands = self.split_commands input
                fs = self.build_filesystem commands
                sizes = self.dir_sizes fs
                sizes.filter {|path, size| size <= 100000 }.sum {|path, size| size}
            end
        end
    end
end
