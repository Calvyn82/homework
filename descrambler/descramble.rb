class Reader
  def initialize(statement)
    @statement = statement.chars
  end

  attr_reader :statement

  def permutations
    statement.permutation.to_a.uniq.map do |array|
      array.join
    end
  end
end

class Scanner
  def initialize(statement, filename = "/usr/share/dict/words")
    @statement  = statement
    @filename   = filename
  end

  attr_reader :statement, :filename

  def run
    list        = Reader.new(statement).permutations
    hits        = Array.new
    File.foreach(filename) do |word|
      if list.include?(word.strip)
        hits << word
      end
    end
    return hits
  end
end

statement = ARGV.last
puts Scanner.new(statement).run
