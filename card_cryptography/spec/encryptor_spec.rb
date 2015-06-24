require_relative "../lib/card_cryptography/encryptor"

describe Cipher::Encryptor do
  it "adds the converted message and the keystream" do
    statement = Cipher::Encryptor.new("Code in Ruby, live longer!")
    statement.convert_to_numbers
    expect(statement.encrypt_numbers).to eq([7, 12, 14, 3, 17, 13, 10, 1, 6, 6, 6, 22, 15, 13, 2, 10, 9, 25, 3, 2])
  end

  it "converts the encrypted message into letters" do
    statement = Cipher::Encryptor.new("Code in Ruby, live longer!")
    statement.convert_to_numbers
    statement.encrypt_numbers
    expect(statement.convert_to_letters).to eq(["G", "L", "N", "C", "Q", "M", "J", "A", "F", "F", "F", "V", "O", "M", "B", "J", "I", "Y", "C", "B"])
  end

  it "creates the encrypted message" do
    statement = Cipher::Encryptor.new("Code in Ruby, live longer!")
    expect(statement.encrypt_message).to eq("GLNCQ MJAFF FVOMB JIYCB")
  end
end

