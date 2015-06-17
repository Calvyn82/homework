module Cipher
  class Deck
    def initialize
      @cards = Array.new(52)
    end
    attr_reader :cards
    private     :cards

    def build(shuffle = false)
      @cards.fill { |i| (i + 1) }
      @cards << "A"
      @cards << "B"
      if shuffle
        @cards.shuffle!
      end
      return cards
    end

    def move_a_joker
      build
      start = cards.index("A")
      if cards[-1] == "A"
        @cards.pop.unshift("A")
      else
        @cards.delete("A")
        @cards.insert((start + 1), "A")
      end
      return cards
    end

    def move_b_joker
      move_a_joker
      start = cards.index("B")
      if cards[-2..-1].include?("B")
        b_at_end
      else
        @cards.delete("B")
        @cards.insert((start + 2), "B")
      end
      return cards
    end

    private

    def b_at_end
      if cards[-1] == "B"
        @cards.delete("B")
        @cards.insert(2, "B")
      else
        @cards.delete("B")
        @cards.insert(1, "B")
      end
    end
  end
end
