module Cipher
  class Encryptor
    def initialize(statement)
      @statement = statement
      @deck      = Array.new(52)
    end

    attr_reader :statement
    private     :statement

    def prepare
      discard_non_letters
      all_caps_string
      append_xtra
      space_insertion
    end

    def discard_non_letters
      @statement = statement
        .chars
        .keep_if { |a| a[/[A-Za-z]/] }
    end

    def all_caps_string
      @statement = statement
        .join
        .upcase
    end

    def append_xtra
      if statement.length % 5 != 0
        @statement << "X" * (5 - statement.length % 5)
      end
    end

    def space_insertion
      separated = [ ]
      @statement = statement.chars
      statement.each_slice(5) { |group| separated << group + [" "] }
      @statement = separated
      @statement = statement.join.strip
    end

    def build_deck
      @deck.fill { |i| (i + 1).to_s }
      @deck << "A"
      @deck << "B"
    end
  end
end
