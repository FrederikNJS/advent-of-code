require 'pry'
require 'ruby-progressbar'

module Day201916
    def Day201916.single_phase(input)
        result = Array.new(input.length)
        prev = 0
        (input.length - 1).downto(0).each do |n|
            prev = (input[n] + prev) % 10
            result[n] = prev
        end
        result
    end

    def Day201916.multi_phase(input, n)
        res = input
        progressbar = ProgressBar.create(
            :title => "Phase",
            :total => n,
            :format => "%t |%B| %c/%C %e"
        )
        n.times do |x|
            progressbar.progress = x
            res = single_phase(res)
        end
        progressbar.finish
        res
    end

    if __FILE__ == $0
        input = File.read('2019/16/puzzle-input.txt').chomp.chars.map { |char| char.to_i }
        #input = [0,3,0,3,6,7,3,2,5,7,7,2,1,2,9,4,4,0,6,3,4,9,1,5,6,5,4,7,4,6,6,4]
        offset = input.take(7).join.to_i
        new_input = (input * 10000).drop(offset)
        puts multi_phase(new_input, 100).take(8).join
    end
end
