require 'pry'
require 'set'

def read_edges
  regex = /^Step (?<start>[A-Z]) must be finished before step (?<end>[A-Z]) can begin\.$/
  File.readlines('2018/07/puzzle-input.txt')
      .map(&:strip)
      .map { |line| regex.match(line) }
      .map { |match| { start: match[:start], end: match[:end] } }
end

def calculate_candidate_steps(dependencies, completed, work_assignments)
  dependencies.select do |vertex, dependency_set|
    !completed.include?(vertex) && dependency_set.subset?(completed) && !work_assignments.select{|assignment| !assignment.nil?}.map {|assignment| assignment[:task]}.include?(vertex)
  end.keys.sort
end

def insert_edge(dependencies, edge)
  dependencies[edge[:end]] = Set.new unless dependencies.include? edge[:end]
  dependencies[edge[:start]] = Set.new unless dependencies.include? edge[:start]
  dependencies[edge[:end]].add edge[:start]
end

def clear_completed(step, work_assignments, completed_steps)
  work_assignments.size.times do |index|
    unless work_assignments[index].nil? || work_assignments[index][:finishes_at] > step
      completed_steps << work_assignments[index][:task]
      work_assignments[index] = nil
    end
  end
end

def run
  all_dependencies = {}
  read_edges.each do |edge|
    insert_edge all_dependencies, edge
  end
  completed_steps = []
  workers = 5
  step_counter = 0
  work_assignments = Array.new workers
  while completed_steps.size < all_dependencies.size
    clear_completed step_counter, work_assignments, completed_steps
    candidate_steps = calculate_candidate_steps(all_dependencies,
                                                completed_steps.to_set,
                                                work_assignments)
    puts "completed #{completed_steps}"
    unless candidate_steps.empty?
      work_assignments.each_with_index do |work_assignment, index|
        next if !work_assignment.nil? || candidate_steps.empty?
        new_task = candidate_steps.shift
        work_assignments[index] = {
          task: new_task,
          finishes_at: (new_task.ord - 4) + step_counter
        }
      end
    end
    puts "Assignments: #{work_assignments}"
    step_counter += 1
  end
  puts step_counter - 1
end

run
