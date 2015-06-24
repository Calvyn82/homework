require_relative "../lib/card_cryptography/decryptor"

describe Cipher::Decryptor do
  it "subtracts the keystream from the converted message" do
    cipher     = Cipher::Encryptor.new("Code in Ruby, live longer!")
    statement  = cipher.encrypt_message
    message    = Cipher::Decryptor.new(message: statement, keyed_deck: Cipher::Deck.new)
    message.setup
    expect(message.decrypt_numbers).to eq([3, 15, 4, 5, 9, 14, 18, 21, 2, 25, 12, 9, 22, 5, 12, 15, 14, 7, 5, 18])
  end

  it "converts the decrypted message into letters" do
    cipher     = Cipher::Encryptor.new("Code in Ruby, live longer!")
    statement  = cipher.encrypt_message
    message    = Cipher::Decryptor.new(message: statement, keyed_deck: Cipher::Deck.new)
    message.setup
    message.decrypt_numbers
    expect(message.convert_to_letters).to eq(["C", "O", "D", "E", "I", "N", "R", "U", "B", "Y", "L", "I", "V", "E", "L", "O", "N", "G", "E", "R"])
  end

  it "decrypts the encrypted message" do
    cipher     = Cipher::Encryptor.new("Code in Ruby, live longer!")
    statement  = cipher.encrypt_message
    message    = Cipher::Decryptor.new(message: statement, keyed_deck: Cipher::Deck.new)
    expect(message.decrypt_message).to eq("CODEI NRUBY LIVEL ONGER")
  end
end
