require 'pry'
require 'ruby-progressbar'

def read_file
  File.readlines('2018/12/puzzle-input.txt')
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
  iterations = 50_000_000_000
  memory_items = 10
  lines = read_file
  initial_state = parse_initial_state lines
  rules = parse_rules lines

  state = Hash.new '.'
  initial_state.split('').each.with_index { |value, index| state[index] = value if value == '#' }

  last_x_diffs = []
  iterations.times do |iteration|
    min, max = state.keys.minmax

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

    # steady-state detector
    last_x_diffs << new_state.keys.sum - state.keys.sum
    last_x_diffs.shift if last_x_diffs.length > memory_items
    puts last_x_diffs.join ', '
    if last_x_diffs.length == memory_items && last_x_diffs.all? { |diff| diff == last_x_diffs[0] }
      puts 'pattern detected! Fast-forwarding'
      result = new_state.keys.sum + (iterations - iteration - 1) * last_x_diffs[0]
      puts "Extrapolated result is #{result}"
      break
    end

    state = new_state
  end
end

run
