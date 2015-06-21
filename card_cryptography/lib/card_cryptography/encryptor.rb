require_relative "deck"

module Cipher
  class Encryptor
    def initialize(statement)
      @statement     = statement
      @deck          = Deck.new
      @encrytion     = nil
    end

    attr_reader :statement, :deck, :encryption, :starting_deck
    private     :statement, :deck, :encryption, :starting_deck

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
      keystream       = [ ]
      message_numbers.size.times do
        keystream << @deck.output_card
      end
      keystream
    end

    def encrypt_numbers
      keystream  = generate_keystream
      @encryption = statement.split(" ").map { |num| num.to_i }
        .zip(keystream).map { |pair| pair.reduce(:+) }
      @encryption = encryption.map do |number| 
        if number > 26
          number - 26
        else
          number
        end
      end
    end

    def convert_to_letters
      alphabet = ("A".."Z").to_a
      @encryption = encryption.map { |number| alphabet[number - 1] }
    end

    def encrypt_message
      groups = [ ]
      convert_to_numbers
      encrypt_numbers
      convert_to_letters
      encryption.each_slice(5) { |group| groups << group + [" "] }
      @encryption = groups.join.strip
    end
  end
end
