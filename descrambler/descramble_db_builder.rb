DATABASE = "descrambler_db.txt"

def import(filename = "/usr/share/dict/words")
  dictionary = Hash.new
  File.foreach(filename) do |word|
    word.strip!
    normalized = normalize(word)
    dictionary[normalized] ||= Array.new
    dictionary[normalized] << word
  end
  return dictionary
end

def normalize(word)
  word.chars.sort.join
end

def find_in_database(normalized, database = DATABASE)
  File.foreach(database) do |line|
    dictionary = line.split("=>")
    if normalized == dictionary.first
      return dictionary.last.split("|")
    end
  end
end
  
def create_database(database = DATABASE)
  File.open(database, "w") do |f|
    import.each do |key, value|
      f.puts "#{key}=>#{value.join("|")}"
    end
  end
end

def descramble(normalized, database = DATABASE)
  if File.exist?(database)
    find_in_database(normalized, database)
  else
    create_database(database)
    find_in_database(normalized, database)
  end
end

input = ARGV.last
puts descramble(normalize(input))
