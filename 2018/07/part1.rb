require 'pry'
require 'set'

def read_edges
  regex = /^Step (?<start>[A-Z]) must be finished before step (?<end>[A-Z]) can begin\.$/
  File.readlines('07/puzzle-input.txt')
      .map(&:strip)
      .map { |line| regex.match(line) }
      .map { |match| { start: match[:start], end: match[:end] } }
end

def calculate_candidate_steps(dependencies, completed)
  dependencies.select do |vertex, dependency_set|
    !completed.include?(vertex) && dependency_set.subset?(completed)
  end.keys.sort
end

def insert_edge(dependencies, edge)
  dependencies[edge[:end]] = Set.new unless dependencies.include? edge[:end]
  dependencies[edge[:start]] = Set.new unless dependencies.include? edge[:start]
  dependencies[edge[:end]].add edge[:start]
end

def run
  dependencies = {}
  read_edges.each do |edge|
    insert_edge dependencies, edge
  end
  completed_steps = []
  while completed_steps.size < dependencies.size
    candidate_steps = calculate_candidate_steps dependencies, completed_steps.to_set
    completed_steps << candidate_steps[0]
  end
  puts completed_steps.join
end

run
