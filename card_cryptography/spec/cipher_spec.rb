require_relative "../lib/card_cryptography/encryptor"

describe Cipher::Encryptor do
  it "discards any non-letter characters" do
    statement = Cipher::Encryptor.new("Code in Ruby, live longer!")
    expect(statement.discard_non_letters).to eq(["C", "o", "d", "e", "i", "n", "R", "u", "b", "y", "l", "i", "v", "e", "l", "o", "n", "g", "e", "r"])
  end

  it "creates an all-caps string" do
    statement = Cipher::Encryptor.new("Code in Ruby, live longer!")
    statement.discard_non_letters
    expect(statement.all_caps_string).to eq("CODEINRUBYLIVELONGER")
  end

  it "appends any needed X's" do
    statement = Cipher::Encryptor.new("Code in Ruby, be happy")
    statement.discard_non_letters
    statement.all_caps_string
    expect(statement.append_xtra).to eq("CODEINRUBYBEHAPPYXXX")
  end

  it "inserts a space between every fifth letter" do
    statement = Cipher::Encryptor.new("Code in Ruby, live longer!")
    statement.discard_non_letters
    statement.all_caps_string
    statement.append_xtra
    expect(statement.space_insertion).to eq ("CODEI NRUBY LIVEL ONGER")
  end

  it "prepares the statement to be encrypted" do
    statement = Cipher::Encryptor.new("Code in Ruby, be happy")
    expect(statement.prepare).to eq("CODEI NRUBY BEHAP PYXXX")
  end

  it "has a deck of 54 cards with an 'A' joker and a 'B' joker" do
    deck = Cipher::Encryptor.new("XXXXX")
    expect(deck.build_deck).to eq(["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50", "51", "52", "A", "B"])
  end
end
