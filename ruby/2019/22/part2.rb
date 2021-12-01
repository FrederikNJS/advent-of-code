module Day201922Part2
    def self.deal_into_new_deck(max, index)
        max - index
    end

    def self.cut(max, index, n)
        index + n % (max + 1)
    end

    def self.deal_with_increment(max, index, increment)
        index * increment % (max + 1)
    end

    def self.shuffle(max, index, instructions)
        instructions.each do |instruction|
            case instruction
            when /^deal into new stack$/
                index = deal_into_new_deck(max, index)
            when /^deal with increment ([0-9]+)$/
                increment = $1.to_i
                index = deal_with_increment(max, index, increment)
            when /^cut (-?[0-9]+)$/
                pos = $1.to_i
                index = cut(max, index, pos)
            end
        end
        index
    end

    if __FILE__ == $0
        input = File.readlines('2019/22/puzzle-input.txt')
            .map {|line| line.chomp}.to_a

        card_count = 119315717514047
        max = card_count - 1
    end
end
