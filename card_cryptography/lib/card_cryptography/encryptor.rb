module Cipher
  class Encryptor
    def initialize(statement)
      @statement = statement
    end

    attr_reader :statement

    def prepare
      @statement = statement
        .chars
        .keep_if { |a| a[/[A-Za-z]/] }
        .join
        .upcase
      append_xtra
      space_insertion_loop
      return statement
    end

    def append_xtra
      ((5 - statement.length) % 5).times do
        @statement << "X"
      end
    end

    def space_insertion_loop
      i = 0
      while i < (statement.length/5 - 1)
        @statement.insert(5 + (5 * i) + i, " ")
        i += 1
      end
    end
  end
end
