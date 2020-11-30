require 'pry'

lines = File.readlines('2018/04/puzzle-input.txt').map(&:strip)
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

asleep_minutes_stats = guards.entries.map do |guard, shifts|
  asleep_minute_counter = Array.new(60, 0)
  shifts.each do |shift|
    shift.each_slice(2) do |sleep, wake|
      (sleep[:minute]...wake[:minute]).each do |minute|
        asleep_minute_counter[minute] += 1
      end
    end
  end
  [guard, asleep_minute_counter]
end.to_h

clockwork_guard = asleep_minutes_stats.max_by { |_guard, stats| stats.max }

most_asleep_minute = clockwork_guard[1].index(clockwork_guard[1].max)
puts "Guard #{clockwork_guard[0]} sleeps most regularly at #{most_asleep_minute}."

puts "Result is #{clockwork_guard[0] * most_asleep_minute}"

binding.pry
