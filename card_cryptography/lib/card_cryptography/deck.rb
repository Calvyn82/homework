module Cipher
  class Deck
    def initialize(shuffle: false)
      @cards   = Array.new(52).fill { |i| i + 1 } + ["A", "B"]
      if shuffle
        @cards.shuffle!
      end
    end
    attr_reader :cards
    private     :cards

    def move_joker(letter:, distance:)
      start = cards.index(letter)
      if cards[(-distance)..-1].include?(letter)
        @cards.delete(letter)
        @cards.insert((start - (53 - distance)), letter)
      else
        @cards.delete(letter)
        @cards.insert((start + distance), letter)
      end
    end

    def triple_cut
      move_joker(letter: "A", distance: 1)
      move_joker(letter: "B", distance: 2)
      first_group = cards.take_while { |card| 
        cards.index(card) < cards.index("A") && cards.index(card) < cards.index("B") }
      last_group  = [ ]
      cards.each_with_index { |card, i| 
        last_group << card if i > cards.index("A") && i > cards.index("B")}
      @cards = (cards - (first_group + last_group)).unshift(last_group)
        .concat(first_group)
        .flatten!
    end

    def count_cut
      triple_cut
      last_card = [cards[-1]]
      move_list = @cards[0..(cards[-1] - 1)]
      @cards = cards - (move_list + last_card)
      @cards << (move_list + last_card)
      @cards.flatten!
    end

    def output_card
      count_cut
      if cards.first == "A"
        if cards[53] == "B"
          output_card
        else
          return convert_down_output(cards[53])
        end
      elsif cards.first == "B"
        output_card
      else
        if cards[cards.first] == "B" || cards[cards.first] == "A"
          output_card
        else
          return convert_down_output(cards[cards.first])
        end
      end
    end

    private

    def convert_down_output(card)
      if card > 26
        card = card - 26
      end
      card
    end
  end
end
