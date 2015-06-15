def find_largest(numbers)
  master_list = Array.new
  list = numbers.permutation.to_a
  list.map do |l|
    master_list << l.join
  end
  master_list.sort.last
end
numbers = [1, 20, 3, 49, 442]
puts find_largest(numbers)
