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
end
