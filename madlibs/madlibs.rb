class Questions
  def initialize(filename)
    @filename   = filename
    @text       = nil
    @madlibs    = nil
  end

  attr_reader :filename, :text, :madlibs

  def load_text
    @text = File.read(filename).gsub("\n", " ")
  end

  def load_madlibs
    @madlibs = @text.scan(/\(\([^)]*\)\)/)
  end
end

class Answers
  def initialize(questions = Questions.new("lunch.txt"))
    @questions  = questions
    @responses  = [ ]
    @text       = questions.load_text
  end

  attr_reader :questions, :responses, :text

  def ask_for
    puts "Here come the madlibs."
    @questions.load_madlibs.each do |question|
      puts question
      @responses << gets.strip
    end
  end

  def swap_in
    responses.each_index do |i|
      @text.sub!(/\(\([^)]*\)\)/, responses[i])
    end
  end
end

class Madlibs
  def initialize(answers = Answers.new)
    @answers = answers
  end

  attr_reader :answers

  def run
    answers.ask_for
    answers.swap_in
    puts answers.text
  end
end

Madlibs.new.run
