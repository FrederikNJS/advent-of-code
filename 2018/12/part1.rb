require 'pry'

def read_file
  File.readlines('12/puzzle-input.txt')
      .map(&:strip)
end

def parse_initial_state(lines)
  regex = /^initial state: ([.#]+)$/
  regex.match(lines[0])[1]
end

def parse_rules(lines)
  regex = /^(?<pattern>[.#]+) => (?<result>[.#])$/
  Hash[
    lines.drop(2)
         .map { |line| regex.match(line) }
         .map { |match| [match['pattern'], match['result']] }
  ]
end

def run
  iterations = 20
  lines = read_file
  initial_state = parse_initial_state lines
  rules = parse_rules lines

  state = Hash.new '.'
  initial_state.split('').each.with_index { |value, index| state[index] = value if value == '#' }

  iterations.times do |iteration|
    # debug
    min, max = state.keys.minmax
    puts "#{iteration}: #{(min..max).map { |key| state[key] }.join}"

    new_state = Hash.new '.'

    ((min - 3)..(max + 3)). each do |key|
      current_pattern = [
        state[key - 2],
        state[key - 1],
        state[key],
        state[key + 1],
        state[key + 2]
      ].join
      result = rules[current_pattern]
      new_state[key] = result if result == '#'
    end
    state = new_state
  end

  min, max = state.keys.minmax
  puts "#{iterations}: #{(min..max).map { |key| state[key] }.join}"

  puts "sum of pots with plants #{state.keys.sum}"
end

run
