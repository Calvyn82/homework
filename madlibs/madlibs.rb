class Questions
  def initialize(filename)
    @filename   = filename
    @text       = nil
  end

  attr_reader :filename, :text

  def load_text
    @text = File.read(filename)
  end

  def load_madlibs
    @text.gsub("\n", " ").scan(/\(\([^)]*\)\)/)
  end
end

class Answers
  def initialize(questions = Questions.new("gift.txt"))
    @questions  = questions
    @responses  = [ ]
    @text       = questions.load_text
    @marked     = { }
  end

  attr_reader :questions, :responses, :text, :marked

  def ask_for
    puts "Here come the madlibs."
    @questions.load_madlibs.each do |question|
      query = question.match(/([^(].*[^)])/)
      p query[1]
      if query[1].include?(":")
        save = query[1].match(/\A(.+):/)
        puts question
        answer = gets.strip
        @marked[save[1]] = answer
        @responses << answer
      elsif @marked.has_key?(query[1])
        @responses << @marked[query[1]]
      else
        puts question
        @responses << gets.strip
      end
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
