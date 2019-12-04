require_relative '../../../2019/03/part2.rb'

RSpec.describe '2019/03/Part1' do
#    it 'can merge paths' do
#        a = ['R8','U5','L5','D3'].map { |item| parse_instruction item }
#        b = ['U7','R6','D4','L4'].map { |item| parse_instruction item }
#        path_a = build_path a
#        path_b = build_path b
#
#        merged_path = merge_paths(path_a, path_b)
#
#        expected = Set[
#            {x: 1, y: 0},
#            {x: 2, y: 0},
#            {x: 3, y: 0},
#            {x: 4, y: 0},
#            {x: 5, y: 0},
#            {x: 6, y: 0},
#            {x: 7, y: 0},
#            {x: 8, y: 0},
#            {x: 8, y: 1},
#            {x: 8, y: 2},
#            {x: 8, y: 3},
#            {x: 8, y: 4},
#            {x: 8, y: 5},
#            {x: 7, y: 5},
#            {x: 6, y: 5},
#            {x: 5, y: 5},
#            {x: 4, y: 5},
#            {x: 3, y: 5},
#            {x: 3, y: 4},
#            {x: 3, y: 3},
#            {x: 3, y: 2},
#            {x: 0, y: 1},
#            {x: 0, y: 2},
#            {x: 0, y: 3},
#            {x: 0, y: 4},
#            {x: 0, y: 5},
#            {x: 0, y: 6},
#            {x: 0, y: 7},
#            {x: 1, y: 7},
#            {x: 2, y: 7},
#            {x: 3, y: 7},
#            {x: 4, y: 7},
#            {x: 5, y: 7},
#            {x: 6, y: 7},
#            {x: 6, y: 6},
#            {x: 6, y: 4},
#            {x: 6, y: 3},
#            {x: 5, y: 3},
#            {x: 4, y: 3},
#            {x: 2, y: 3},
#        ]
#
#        expect(merged_path).to eq expected
#    end
#
#    it 'can find shortest paths' do
#        a = ['R8','U5','L5','D3'].map { |item| parse_instruction item }
#        b = ['U7','R6','D4','L4'].map { |item| parse_instruction item }
#        graph = build_graph([a, b])
#        edge_weight = lambda { |edge| 1 }
#        shortest_path = graph.dijkstra_shortest_path(edge_weight, "1, 0", "0, 1")
#    end
end
