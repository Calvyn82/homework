class Dictionary
  def initialize(filename = "/usr/share/dict/words")
    @filename = filename
  end

  attr_reader :filename

  def import
    dictionary = Array.new
    File.foreach(filename) do |word|
        dictionary << word
    end
    return dictionary
  end
end

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
  def initialize(statement)
    @statement  = statement
  end

  attr_reader :statement

  def run
    list        = Reader.new(statement).permutations
    dictionary  = Dictionary.new.import
    hits        = Array.new
    dictionary.each do |word|
      if list.include?(word.strip)
        hits << word
      end
    end
    return hits
  end
end



statement = ARGV.last
puts Scanner.new(statement).run
