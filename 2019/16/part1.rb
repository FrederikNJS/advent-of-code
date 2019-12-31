require 'pry'
require 'ruby-progressbar'

module Day201916
    PATTERN = [0, 1, 0, -1]

    def Day201916.generate_pattern(n, length)
        result = []
        (length + 1).times do |idx|
            result << PATTERN[(idx % (n * PATTERN.length)) / n]
        end
        result.shift(1)
        result
    end

    def Day201916.single_phase(input)
        result = Array.new(input.length)
        result.length.times do |n|
            result[n] = generate_pattern(n+1, input.length)
                .zip(input)
                .map do |a, b|
                    a * b
                end.sum.abs % 10
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
        #puts input.inspect
        puts multi_phase(input, 100).take(8).join
    end
end
