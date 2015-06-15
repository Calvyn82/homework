require_relative "../lib/card_cryptography/encryptor"

describe Cipher::Encryptor do
  it "discards any non-letter characters, upcase and return in groups of five letters" do
    statement = Cipher::Encryptor.new("Code in Ruby, live longer!")
    expect(statement.prepare).to eq("CODEI NRUBY LIVEL ONGER")
  end

  it "appends X's to string that's length is not a multiple of 5" do
    statement = Cipher::Encryptor.new("Code in Ruby, be happy")
    expect(statement.prepare).to eq("CODEI NRUBY BEHAP PYXXX")
  end

end
