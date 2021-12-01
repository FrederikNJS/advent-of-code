module Day201922Part1
    def self.deal_into_new_deck(deck)
        deck.reverse
    end

    def self.cut(deck, n)
        deck.rotate(n)
    end

    def self.deal_with_increment(deck, increment)
        new_deck = Array.new(deck.length)
        deck.each.with_index do |card, index|
            new_deck[index * increment % deck.length] = card
        end
        new_deck
    end

    def self.shuffle(deck, instructions)
        instructions.each do |instruction|
            case instruction
            when /^deal into new stack$/
                deck = deal_into_new_deck(deck)
            when /^deal with increment ([0-9]+)$/
                increment = $1.to_i
                deck = deal_with_increment(deck, increment)
            when /^cut (-?[0-9]+)$/
                pos = $1.to_i
                deck = cut(deck, pos)
            end
        end
        deck
    end

    if __FILE__ == $0
        input = File.readlines('2019/22/puzzle-input.txt')
            .map {|line| line.chomp}.to_a

        deck = (0..10006).to_a

        new_deck = shuffle(deck, input)
        puts new_deck.index(2019)
    end
end
