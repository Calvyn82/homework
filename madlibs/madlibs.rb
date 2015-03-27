class Questions
  def initialize(filename)
    @filename   = filename
    @text       = nil
    @madlibs    = nil
  end

  attr_reader :filename, :text, :madlibs

  def load
    @text     = File.read(filename).gsub("\n", " ")
    @madlibs  = @text.scan(/\(\([^)]*\)\)/)
  end
end

class Answers
  def initialize(questions = Questions.new("lunch.txt"))
    @questions = questions
    @responses = [ ]
  end

  attr_reader :questions, :responses

  def ask_for
    puts "Here come the madlibs."
    @questions.load.each do |question|
      puts question
      @responses << gets.strip
    end
    puts @responses
  end
end

Answers.new.ask_for
