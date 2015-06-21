module Cipher
  class Cryptor

    attr_reader :statement, :deck, :cryption

    def discard_non_letters
      @statement = statement
        .chars
        .keep_if { |a| a[/[A-Za-z]/] }
    end

    def all_caps_string
      discard_non_letters
      @statement = statement
        .join
        .upcase
    end

    def append_xtra
      all_caps_string
      @statement << "X" * ((5 - statement.length % 5) % 5)
    end

    def space_insertion
      append_xtra
      separated = [ ]
      @statement = statement.chars
      statement.each_slice(5) { |group| separated << group + [" "] }
      @statement = separated.join.strip
    end

    def convert_to_numbers
      space_insertion
      @statement.gsub!(/[A-Z]/) { |letter|
        ((letter.ord - "A".ord) + 1).to_s + " "
      }
        .strip
    end

    def generate_keystream
      message_numbers = statement.split(" ")
      keystream      = [ ]
      message_numbers.size.times do
        keystream << @deck.output_card
      end
      keystream
    end
  end
end
