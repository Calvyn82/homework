require_relative "deck"

module Cipher
  class Encryptor
    def initialize(statement)
      @statement = statement
      @deck      = Deck.new.build
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

    def move_b_joker
      move_a_joker
      start = deck.index("B")
      if deck[-2..-1].include?("B")
        b_at_end
      else
        @deck.delete("B")
        @deck.insert((start + 2), "B")
      end
      return deck
    end

    def triple_cut
      move_b_joker
    end

    private

    def b_at_end
      if deck[-1] == "B"
        @deck.delete("B")
        @deck.insert(2, "B")
      else
        @deck.delete("B")
        @deck.insert(1, "B")
      end
    end
  end
end
