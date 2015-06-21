require_relative "deck"

module Cipher
  class Encryptor
    def initialize(statement)
      @statement = statement
      @deck      = Deck.new.count_cut
    end

    attr_reader :statement, :deck
    private     :statement, :deck

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
      @statement = separated
      @statement = statement.join.strip
    end

    def convert_to_numbers
      space_insertion
      @statement.gsub(/[A-Z]/) { |letter| 
        ((letter.ord - "A".ord) + 1).to_s + " "  
      }
          .strip
    end

  end
end
