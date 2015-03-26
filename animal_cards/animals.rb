animals_per_card = ARGV[0].to_i
animals = ARGV[1..-1]
cards = Array.new(animals_per_card + 1)
animals.each_index do |i|
  cards[i] = Array.new(animals_per_card) { |a| animals[i - a] }
end
cards.each do |card|
  puts card.join(", ")
end
