path = File.dirname(__FILE__)
jobs = File.read("#{path}/jobs.txt")
puts "What are you working on?"
puts "------------------------"
puts jobs
puts "------------------------"
puts "Insert number or free text: "
input = gets.chomp
job = nil
jobs.split("\n").each do |x|
  if x.start_with?(input)
    job = x
    break
  end
end

log = File.read("#{path}/log.txt")
running = log.split("\n").last

if running
  running.gsub!(/\d+$/, Time.now.strftime("%d%m%y%H%M%S"))
end

job = input unless job

File.open("#{path}/log.txt", 'a') do |f|
  f.write("#{running}\n") if running
  f.write("#{job} #{Time.now.strftime("%d%m%y%H%M%S")}\n")
end

# log = File.read("#{path}/log.txt")
# one = log[-1]
# two = log[-2]

# if one && two
#   one.match(/\d+$/).first
# end

puts "Done!"
