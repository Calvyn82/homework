def build_fibo(fibo)
  fibo[0] = 0
  fibo[1] = 1
  fibo.each_index do |i|
    unless i == 0 || i == 1
      fibo[i] = fibo[i - 1] + fibo[i - 2]
    end
  end
end
fibo = Array.new(100)
puts build_fibo(fibo)
