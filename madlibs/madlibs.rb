class Questions
  def initialize(filename)
    @filename   = filename
  end

  attr_reader :filename

  def load
    file = File.read(filename)
    match = file.scan(/\(\([^)]*\)\)/)
    return match
  end
end

data = Questions.new("lunch.txt")
puts data.load
