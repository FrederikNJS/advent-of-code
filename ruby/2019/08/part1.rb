def create_image(input, width, height)
    input.chars.each_slice(width * height).map { |layer| layer.each_slice(width).to_a }
end

def count_layer_values(layer, value_to_count)
    layer.sum do |row|
        row.count do |pixel|
            pixel == value_to_count
        end
    end
end

def fewest_zero_layer(image)
    zero_count = image.map do |layer|
        count_layer_values(layer, '0')
    end

    layer_index_with_fewest_zeroes = zero_count.index(zero_count.min)
    image[layer_index_with_fewest_zeroes]
end

def image_checksum(layer)
    ones = count_layer_values(layer, '1')
    twos = count_layer_values(layer, '2')
    ones * twos
end

if __FILE__ == $0
    input = File.read('2019/08/puzzle-input.txt').chomp

    image = create_image(input, 25, 6)
    fewest_zero = fewest_zero_layer(image)
    puts image_checksum(fewest_zero)
end
