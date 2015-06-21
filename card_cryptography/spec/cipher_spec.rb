require_relative "../lib/card_cryptography/encryptor"
require_relative "../lib/card_cryptography/deck"

describe Cipher::Encryptor do
  it "discards any non-letter characters" do
    statement = Cipher::Encryptor.new("Code in Ruby, live longer!")
    expect(statement.discard_non_letters).to eq(["C", "o", "d", "e", "i", "n", "R", "u", "b", "y", "l", "i", "v", "e", "l", "o", "n", "g", "e", "r"])
  end

  it "creates an all-caps string" do
    statement = Cipher::Encryptor.new("Code in Ruby, live longer!")
    expect(statement.all_caps_string).to eq("CODEINRUBYLIVELONGER")
  end

  it "appends any needed X's" do
    statement = Cipher::Encryptor.new("Code in Ruby, be happy")
    expect(statement.append_xtra).to eq("CODEINRUBYBEHAPPYXXX")
  end

  it "inserts a space between every fifth letter" do
    statement = Cipher::Encryptor.new("Code in Ruby, live longer!")
    expect(statement.space_insertion).to eq ("CODEI NRUBY LIVEL ONGER")
  end

  it "converts message to numbers" do
    statement = Cipher::Encryptor.new("Code in Ruby, live longer!")
    expect(statement.convert_to_numbers).to eq("3 15 4 5 9  14 18 21 2 25  12 9 22 5 12  15 14 7 5 18")
  end

  it "gets keystream letters" do
    statement = Cipher::Encryptor.new("Code in Ruby, live longer!")
  end
end


describe Cipher::Deck do
  it "has a deck of 54 cards with an 'A' joker and a 'B' joker" do
    deck = Cipher::Deck.new(shuffle: false)
    expect(deck.send(:cards)).to eq([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, "A", "B"])
  end

  it "moves the 'A' joker down one card" do
    deck = Cipher::Deck.new(shuffle: false)
    deck.move_joker(letter: "A", distance: 1) 
    expect(deck.send(:cards).index("A")).to eq(53)
  end

  it "moves the 'B' joker down two cards" do
    deck = Cipher::Deck.new(shuffle: false)
    deck.move_joker(letter: "A", distance: 1) 
    deck.move_joker(letter: "B", distance: 2)
    expect(deck.send(:cards).index("B")).to eq(1)
  end

  it "performs a triple cut" do
    deck = Cipher::Deck.new(shuffle: false)
    deck.triple_cut
    expect(deck.send(:cards).index(1)).to eq(53)
  end

  it "performs a count cut using the value of the bottom card" do
    deck = Cipher::Deck.new(shuffle: false)
    deck.count_cut
    expect(deck.send(:cards).index("B")).to eq(52)
  end

  it "gets an output card" do
    deck = Cipher::Deck.new(shuffle: false)
    expect(deck.output_card).to eq(4)
  end

  it "can run multiple output card cycles" do
    deck = Cipher::Deck.new(shuffle: false)
    cards = [ ]
    until cards.size == 10
      cards << deck.output_card
    end
    expect(cards).to eq([4, 23, 10, 24, 8, 18, 6, 4, 7, 20])
  end
end
