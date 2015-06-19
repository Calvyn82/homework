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

    def move_joker(letter: letter, distance: distance)
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
      first_group = build_first_group
      last_group  = build_last_group
      @cards.delete_if { |card| first_group.include?(card) || last_group.include?(card) }
      @cards.unshift(last_group)
      @cards << first_group
      @cards.flatten!
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

    def build_first_group
      if cards.index("A") < cards.index("B")
        first_group = cards[0..cards.index("A")]
        first_group.delete("A")
      else
        first_group = cards[0..cards.index("B")]
        first_group.delete("B")
      end
      first_group
    end

    def build_last_group
      if cards.index("A") > cards.index("B")
        last_group = cards[cards.index("A")..-1]
        last_group.delete("A")
      else
        last_group = cards[cards.index("B")..-1]
        last_group.delete("B")
      end
      last_group
    end
  end
end
