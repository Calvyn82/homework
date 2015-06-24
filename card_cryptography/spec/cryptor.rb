require_relative "../lib/card_cryptography/cryptor"

describe Cipher::Cryptor do
  it "discards any non-letter characters" do
    statement = Cipher::Cryptor.new("Code in Ruby, live longer!")
    expect(statement.discard_non_letters).to eq(["C", "o", "d", "e", "i", "n", "R", "u", "b", "y", "l", "i", "v", "e", "l", "o", "n", "g", "e", "r"])
  end

  it "creates an all-caps string" do
    statement = Cipher::Cryptor.new("Code in Ruby, live longer!")
    expect(statement.all_caps_string).to eq("CODEINRUBYLIVELONGER")
  end

  it "appends any needed X's" do
    statement = Cipher::Cryptor.new("Code in Ruby, be happy")
    expect(statement.append_xtra).to eq("CODEINRUBYBEHAPPYXXX")
  end

  it "inserts a space between every fifth letter" do
    statement = Cipher::Cryptor.new("Code in Ruby, live longer!")
    expect(statement.space_insertion).to eq ("CODEI NRUBY LIVEL ONGER")
  end

  it "converts message to numbers" do
    statement = Cipher::Cryptor.new("Code in Ruby, live longer!")
    expect(statement.convert_to_numbers).to eq("3 15 4 5 9  14 18 21 2 25  12 9 22 5 12  15 14 7 5 18")
  end

  it "gets keystream numbers" do
    statement = Cipher::Cryptor.new("Code in Ruby, live longer!")
    statement.convert_to_numbers
    expect(statement.generate_keystream).to eq([4, 23, 10, 24, 8, 25, 18, 6, 4, 7, 20, 13, 19, 8, 16, 21, 21, 18, 24, 10])
  end
end
