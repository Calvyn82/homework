WIDTH = 78

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
    @questions.load_madlibs.each do |question|
      query = question.match(/([^(].*[^)])/)
      if query[1].include?(":")
        set_mark(query, question)
      elsif @marked.has_key?(query[1])
        @responses << @marked[query[1]]
      else
        get_response(question)
      end
    end
  end

  def get_response(question)
    puts question
    @responses << gets.strip
  end

  def set_mark(query, question)
    save = query[1].match(/\A(.+):/)
    puts question
    answer = gets.strip
    @marked[save[1]] = answer
    @responses << answer
  end

  def swap_in
    responses.each_index do |i|
      @text.sub!(/\(\([^)]*\)\)/, responses[i])
    end
  end
end

class Madlibs
  def initialize(answers = Answers.new)
    @answers  = answers
    @lines    = [ ]
    @line     = ""
  end

  attr_reader :answers, :lines, :line

  def wrap(string, width = WIDTH)
    loop do
      return string unless string.sub!(/^.{#{width + 1}}/) { |long_line|
        if (i = long_line.rindex(" "))
          long_line[i, 1] = "\n"
        else
          ling_line[-1, 0] = "\n"
        end
        long_line
      }
    end
  end

  def run
    puts "Here come the madlibs."
    answers.ask_for
    answers.swap_in
    puts wrap(answers.text)
  end
end

Madlibs.new.run
