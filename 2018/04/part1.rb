require 'pry'

lines = File.readlines('04/puzzle-input.txt').map(&:strip)
sorted = lines.sort
regex = /^\[(?<year>\d+)-(?<month>\d+)-(?<day>\d+) (?<hour>\d+):(?<minute>\d+)\] (?<message>Guard #(?<guard>\d+) begins shift|falls asleep|wakes up)$/
parsed = sorted.map { |line| regex.match line }.map do |match|
  {
    year: match[:year].to_i,
    month: match[:month].to_i,
    day: match[:day].to_i,
    hour: match[:hour].to_i,
    minute: match[:minute].to_i,
    message: match[:message],
    guard: match[:guard].nil? ? nil : match[:guard].to_i
  }
end

guards = {}

current_guard = nil
parsed.each do |entry|
  if entry[:guard].nil?
    # current_shift << entry
    guards[current_guard].last << entry
  else
    guards[entry[:guard]] = [] unless guards.key? entry[:guard]
    guards[entry[:guard]] << []
    current_guard = entry[:guard]
  end
end

def shift_sleep(shift)
  minutes_asleep = 0
  shift.each_slice(2) {|a, b| minutes_asleep += b[:minute] - a[:minute] }
  minutes_asleep
end

guard_sleep_timers = guards.entries.map do |guard, shifts|
  [
    guard,
    shifts.map(&method(:shift_sleep)).sum
  ]
end.to_h

most_asleep_guard = (guard_sleep_timers.max_by { |_guard, time| time })[0]
puts "Guard #{most_asleep_guard} sleeps the most."
asleep_minute_counter = Array.new(60, 0)

guards[most_asleep_guard].each do |shift|
  shift.each_slice(2) do |sleep, wake|
    (sleep[:minute]...wake[:minute]).each do |minute|
      asleep_minute_counter[minute] += 1
    end
  end
end

most_asleep_minute = asleep_minute_counter.index(asleep_minute_counter.max)
puts "Guard #{most_asleep_guard} sleeps most often at minute #{most_asleep_minute}."

puts "Result is #{most_asleep_guard * most_asleep_minute}"
