class Questions
  def initialize(filename)
    @filename   = filename
    @text = nil
  end

  attr_reader :filename, :text

  def load
    file = File.read(filename).gsub("\n", " ")
    @text = file.scan(/\(\([^)]*\)\)/)
  end
end

class Answers
  def initialize(questions = Questions.new("lunch.txt"))
    @questions = questions
    @responses = [ ]
  end

  attr_reader :questions

  def ask_for
    puts "Here come the questions."
    @questions.load.each do |question|
      puts question
      @responses << gets.strip
    end
    puts @responses
  end
end

Answers.new.ask_for
