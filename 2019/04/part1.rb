require 'pry'

def has_adjacent_digits?(number)
    str = number.to_s
    return str[0] == str[1] || str[1] == str[2] || str[2] == str[3] || str[3] == str[4] || str[4] == str [5]
end

def has_increasing_digits?(number)
    str = number.to_s
    return str[0] <= str[1] && str[1] <= str[2] && str[2] <= str[3] && str[3] <= str[4] && str[4] <= str [5]
end

if __FILE__ == $0
    a,b = File.read('2019/04/puzzle-input.txt').chomp.split('-').map { |str| str.to_i }
    puts (a..b).filter { |number| has_adjacent_digits? number}
        .filter { |number| has_increasing_digits? number}
        .length
end
