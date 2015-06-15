def evil
  i = 0
  while i == i
    p "stop"
    i += 1
    raise if i > 5
  end
rescue RuntimeError
  return p "Don't do that"
end

evil
