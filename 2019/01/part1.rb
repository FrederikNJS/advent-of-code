def fuel_calc1(weight)
    return (weight / 3).floor - 2
end

if __FILE__ == $0
    weights = File.readlines('2019/01/puzzle-input.txt')
        .map(&:strip)
        .map(:to_o)

    sum = 0

    fuels = weights.map(&:fuel_calc1)
    puts fuels.sum
end
