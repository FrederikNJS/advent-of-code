require_relative 'part1.rb'

def resolve_image(image, width, height)
    height.times.map do |y|
        width.times.map do |x|
            image.map { |layer| layer[y][x] }.find { |item| item != "2" }
        end
    end
end

if __FILE__ == $0
    input = File.read('2019/08/puzzle-input.txt').chomp

    image = create_image(input, 25, 6)
    flattened_image = resolve_image(image, 25, 6)
    flattened_image.each do |row|
        puts row.map { |item| item == "1" ? "#" : " "}.join
    end
end
