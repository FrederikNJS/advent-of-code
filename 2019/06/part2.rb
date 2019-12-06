def orbit_tree(lines)
    orbits = lines.map { |line| line.split ')' }
    tree = {}
    orbits.each { |orbit| tree[orbit[1]] = orbit[0] }
    tree
end

def orbit_path(tree, obj)
    path = []
    current = obj
    until current == "COM"
        current = tree[current]
        path << current
    end
    path
end

def orbit_route(a, b)
    result = nil
    a.each.with_index do |elem, index|
        index2 = b.index(elem)
        unless index2.nil?
            result = index + index2
            return result
        end
    end
    return nil
end

if __FILE__ == $0
    input = File.readlines('2019/06/puzzle-input.txt').map(&:chomp)

    tree = orbit_tree input
    path_a = orbit_path(tree, 'YOU')
    path_b = orbit_path(tree, 'SAN')
    result  = orbit_route(path_a, path_b)
    puts result
end
