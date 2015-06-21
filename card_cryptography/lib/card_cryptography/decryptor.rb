module Cipher
  class Decryptor < Encryptor
    def initialize(message:, keyed_deck:)
      @statement  = message
      @deck       = keyed_deck
      @decryption = nil
    end

    attr_reader :statement, :deck, :decryption
    private     :statement, :deck, :decryption


    def decrypt_numbers
      keystream   = generate_keystream
      @statement = statement.split(" ").map { |num| num.to_i }
      @statement.each_with_index do |number, i|
        if number <= keystream[i]
          @statement[i] = number + 26
        end
      end
      @decryption = statement.zip(keystream).map { |pair| pair.reduce(:-) }
    end

    def convert_to_letters
      alphabet = ("A".."Z").to_a
      @decryption = decryption.map { |number| alphabet[number - 1] }
    end

    def decrypt_message
      groups = [ ]
      convert_to_numbers
      decrypt_numbers
      convert_to_letters
      decryption.each_slice(5) { |group| groups << group + [" "] }
      @decryption = groups.join.strip
    end
  end
end
