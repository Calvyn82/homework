class Game
  def initialize(cards, target)
    @cards        = cards.sort
    @target       = target
    @found_answer = false
    @operators    = [:+, :-, :*, :/]
    @cycles       = 0
  end

  attr_reader :cards, :target, :guesses, :found_answer, :operators, :cycles
  private :cards, :target, :guesses, :found_answer, :operators, :cycles

  def run
    incredibly_lucky?
    run_permutations
  end

  private

  def incredibly_lucky?
    if cards.include?(target)
      puts "The #{numbers.select { |num| num == target }[0]} card is the same as the target"
      exit
    end
  end

  def build_initial_permutations
    cards.permutation.to_a # build arrays with 2 cards each
  end

  def run_permutations(number_perms = build_initial_permutations)
    p number_perms
    number_perms.each_with_index do |list, list_i|
      list.each_with_index do |num, num_i|
      end
    end
  end

  def build_next_perm(sum)
   sum_array = Array.new(6) { sum }
   sum_array.zip(cards)
  end

  def build_guesses(operator:, operator_index:, numbers:, numbers_index:)
    @guesses[cycles][operator_index][numbers_index] = ([numbers[0], operator, numbers[1]])
  end
end

target  = ARGV[0]
cards   = ARGV[1..-1].to_a
abort "Please give six cards" unless cards.size == 6
abort "All cards must be numeric" unless cards.all? { |c| c =~ /\A\d+\z/ }
abort "The target must be numeric" unless target =~ /\A\d+\z/
target = target.to_i
cards = cards.map { |card| card.to_i }
puts Game.new(cards, target).run
