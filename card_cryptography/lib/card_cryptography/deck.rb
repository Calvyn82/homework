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
      last_card = cards[-1]
      move_list = @cards[0..(cards[-1] - 1)]
      @cards.delete_if { |card| move_list.include?(card) }
      @cards.delete(last_card)
      @cards << move_list
      @cards << last_card
      @cards.flatten!
    end

    def output_card
      count_cut
      if cards.first != "A" && cards.first != "B"
        if cards[cards.first] != "A" && cards[cards.first] != "B"
          return cards[cards.first]
        else
          output_card
        end
      else
        output_card
      end
    end
  end
end
