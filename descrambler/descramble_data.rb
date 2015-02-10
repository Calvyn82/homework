def import(filename = "/usr/share/dict/words")
  dictionary = Hash.new
  File.foreach(filename) do |word|
    normalized = normalize(word.strip)
    dictionary[normalized] ||= Array.new
    dictionary[normalized] << word
  end
  return dictionary
end

def normalize(word)
  word.chars.sort.join
end
scrambled = ARGV.last
puts import[normalize(scrambled)]
