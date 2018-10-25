require 'time'

path = File.dirname(__FILE__)
jobs = File.read("#{path}/jobs.txt")

if ARGV[0]
  job = ARGV[0]
else
  puts "What are you working on?"
  puts "------------------------"
  puts jobs
  puts "------------------------"
  puts "Insert number or free text: "

  job = gets.chomp
end

jobs.split("\n").each do |x|
  if x.start_with?(job)
    job = x
    break
  end
end

log_path = "#{path}/log_#{Time.now.strftime('%Y%m')}.txt"

File.write(log_path, '') unless File.file?(log_path)
log = File.read(log_path)
log_lines = log.split("\n")

if log_lines.any?
  running = log_lines.pop
  start = Time.strptime(running.match(/\d+$/)[0], '%d%m%Y%H%M%S')
  duration_in_sec = (Time.now - start).to_i
  elapsed_time = Time.at(duration_in_sec).utc.strftime("%H:%M:%S") # use this in report
  running.gsub!(/\d+$/, "#{start.strftime('%d.%m.%Y')} #{duration_in_sec}")
  log_lines << running
end

log_lines << "#{job} #{Time.now.strftime("%d%m%Y%H%M%S")}"

File.open(log_path, 'w') do |f|
  f.write(log_lines.join("\n"))
end

puts "Successfully added new job! Last job duration was #{elapsed_time}"
