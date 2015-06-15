class Game
  def initialize(cards, target)
    @cards        = cards.sort
    @target       = target
    @found_answer = false
    @operators    = [:+, :-, :*, :/]
  end
end
