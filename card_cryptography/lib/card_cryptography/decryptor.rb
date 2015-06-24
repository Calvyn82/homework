require_relative "cryptor"

module Cipher
  class Decryptor < Cryptor
    def initialize(message:, keyed_deck:)
      @statement  = message
      @deck       = keyed_deck
      @cryption = nil
    end

    attr_reader :statement, :deck, :cryption
    private     :statement, :deck, :cryption


    def decrypt_numbers
      keystream   = generate_keystream
      @statement = statement.split(" ").map { |num| num.to_i }
      @statement.each_with_index do |number, i|
        if number <= keystream[i]
          @statement[i] = number + 26
        end
      end
      @cryption = statement.zip(keystream).map { |pair| pair.reduce(:-) }
    end

    def convert_to_letters
      alphabet = ("A".."Z").to_a
      @cryption = cryption.map { |number| alphabet[number - 1] }
    end

    def decrypt_message
      setup
      groups = [ ]
      decrypt_numbers
      convert_to_letters
      cryption.each_slice(5) { |group| groups << group + [" "] }
      @cryption = groups.join.strip
    end
  end
end
