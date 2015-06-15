def evil 
  while true 
  end 
rescue Interrupt 
  puts 'lolnope' 
  evil 
end

evil
