require_relative "../lib/card_cryptography/decryptor"

describe Cipher::Decryptor do
  it "takes input in the forms of a statement and a keyed deck" do
    cipher     = Cipher::Encryptor.new("Code in Ruby, live longer!")
    statement  = cipher.encrypt_message
    message    = Cipher::Decryptor.new(message: statement, keyed_deck: Cipher::Deck.new)
    expect(message.send(:statement)).to eq("GLNCQ MJAFF FVOMB JIYCB")
  end

  it "coverts the message to numbers" do
    cipher     = Cipher::Encryptor.new("Code in Ruby, live longer!")
    statement  = cipher.encrypt_message
    message    = Cipher::Decryptor.new(message: statement, keyed_deck: Cipher::Deck.new)
    expect(message.convert_to_numbers).to eq("7 12 14 3 17  13 10 1 6 6  6 22 15 13 2  10 9 25 3 2")
  end

  it "gets keystream numbers" do
    cipher     = Cipher::Encryptor.new("Code in Ruby, live longer!")
    statement  = cipher.encrypt_message
    message    = Cipher::Decryptor.new(message: statement, keyed_deck: Cipher::Deck.new)
    message.convert_to_numbers
    expect(message.generate_keystream).to eq([4, 23, 10, 24, 8, 25, 18, 6, 4, 7, 20, 13, 19, 8, 16, 21, 21, 18, 24, 10])
  end

  it "subtracts the keystream from the converted message" do
    cipher     = Cipher::Encryptor.new("Code in Ruby, live longer!")
    statement  = cipher.encrypt_message
    message    = Cipher::Decryptor.new(message: statement, keyed_deck: Cipher::Deck.new)
    message.convert_to_numbers
    expect(message.decrypt_numbers).to eq([3, 15, 4, 5, 9, 14, 18, 21, 2, 25, 12, 9, 22, 5, 12, 15, 14, 7, 5, 18])
  end

  it "converts the decrypted message into letters" do
    cipher     = Cipher::Encryptor.new("Code in Ruby, live longer!")
    statement  = cipher.encrypt_message
    message    = Cipher::Decryptor.new(message: statement, keyed_deck: Cipher::Deck.new)
    message.convert_to_numbers
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
