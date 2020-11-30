require_relative '../../../2019/08/part1.rb'

RSpec.describe '2019/08/Part1' do
    it 'it can build an image' do
        input = "123456789012"

        expected = [
            [
                ['1', '2', '3'],
                ['4', '5', '6']
            ],
            [
                ['7', '8', '9'],
                ['0', '1', '2']
            ]
        ]
        width = 3
        height = 2

        result = create_image(input, width, height)

        expect(result).to eq expected
    end

    it 'can find the layer with the fewest zeroes' do
        image = [
            [
                ['1', '2', '3'],
                ['4', '5', '6']
            ],
            [
                ['7', '8', '9'],
                ['0', '1', '2']
            ]
        ]

        layer_with_fewest_zeroes = fewest_zero_layer(image)

        expect(layer_with_fewest_zeroes).to eq image[0]
    end

    it 'can find the layer with the fewest zeroes' do
        image = [
            [
                ['1', '2', '3'],
                ['4', '5', '6']
            ],
            [
                ['7', '8', '9'],
                ['0', '1', '2']
            ]
        ]

        layer_with_fewest_zeroes = fewest_zero_layer(image)

        expect(layer_with_fewest_zeroes).to eq image[0]
    end
end
