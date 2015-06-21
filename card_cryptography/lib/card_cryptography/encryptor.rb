require_relative "cryptor"
require_relative "deck"

module Cipher
  class Encryptor < Cryptor
    def initialize(statement)
      @statement     = statement
      @deck          = Deck.new
      @cryption      = nil
    end

    attr_reader :statement, :deck, :encryption
    private     :statement, :deck, :encryption

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
