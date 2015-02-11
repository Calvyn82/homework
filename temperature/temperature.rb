temperature = ARGV.first.upcase
number = temperature.to_f
if temperature.end_with?("F")
  in_c = (number - 32) * (5.0/9.0)
  puts "#{in_c}C"
elsif temperature.end_with?("C")
  in_f = (number * (9.0/5.0)) + 32 
  puts "#{in_f}F"
end
