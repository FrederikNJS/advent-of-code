def orbit_counter(lines)
    orbits = lines.map { |line| line.split ')' }
    orbit_counts = {
        "COM" => 0
    }
    until orbits.empty?
        orbit = orbits.shift
        if orbit_counts.has_key?(orbit[0])
            orbit_counts[orbit[1]] = orbit_counts[orbit[0]] + 1
        else
            orbits << orbit
        end
    end
    orbit_counts.values.sum
end

if __FILE__ == $0
    input = File.readlines('2019/06/puzzle-input.txt').map(&:chomp)
    result = orbit_counter input
    puts result
end
