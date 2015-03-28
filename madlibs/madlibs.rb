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
    @wrapped = nil
  end

  attr_reader :answers, :wrapped

  def word_wrap(width = 78)
    # adapted from Ruby Cookbook 
    # (https://www.safaribooksonline.com/library/view/ruby-cookbook/0596523696/ch01s15.html)
    lines = []
    line = ""
    string = @answers.text
    string.split(/\s+/).each do |word|
      if line.size + word.size >= width
        lines << line
        line = word
      elsif line.empty?
        line = word
      else
        line << " " << word
      end
    end
    lines << line if line
    @wrapped = lines.join "\n"
  end

  def run
    answers.ask_for
    answers.swap_in
    word_wrap
    puts wrapped
  end
end

Madlibs.new.run
