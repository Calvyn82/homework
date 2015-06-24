require_relative "../lib/card_cryptography/deck"

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
    expect(cards).to eq([4, 23, 10, 24, 8, 25, 18, 6, 4, 7])
  end
end
