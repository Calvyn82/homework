def while_loop(numbers)
  i = 0
  answer = 0
  while i < (numbers.length)
    answer += numbers[i]
    i += 1
  end
  return answer
end

def each_method(numbers)
  answer = 0
  numbers.each { |number| answer += number }
  return answer
end

numbers = [1, 2, 3, 4, 5]
puts while_loop(numbers)
puts each_method(numbers)
