DATABASE = "database.txt"

class Builder
  def initialize
    @database = DATABASE
  end

  attr_reader :database

  def create_database
    File.open(database, "w") do |f|
      import.each do |key, value|
        f.puts "#{key}=>#{value.join("|")}"
      end
    end
  end

  def import(filename = "/usr/share/dict/words")
    dictionary = Hash.new
    File.foreach(filename) do |word|
      word.strip!
      normalized = word.chars.sort.join
      dictionary[normalized] ||= Array.new
      dictionary[normalized] << word
    end
    return dictionary
  end
end

class Searcher
  def initialize(user_input)
    @user_input = user_input.chars.sort.join
  end

  attr_reader :user_input

  def descramble
    if File.exist?(DATABASE)
      find_in_database
    else
      Builder.new.create_database
      find_in_database
    end
  end

  def find_in_database
    File.foreach(DATABASE) do |line|
      entry = line.split("=>")
      if @user_input == entry.first
        return entry.last.split("|")
      end
    end
  end
end

user_input = ARGV.last
check = Searcher.new(user_input)
puts check.descramble
