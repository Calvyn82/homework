class Madlib
  def initialize(filename)
    @filename   = filename
    @responses  = [ ]
    @marked     = { }
    @string     = nil
  end

  attr_reader :marked

  def get_answers
    File.open(@filename, "r") { |file|
      @string = file.read
      while @string.include?("))")
        @string.sub!(/\(\(([^)]*)\)\)/) { |question|
          p @responses
          if question.include?(":")
            get_response(question)
            question = @responses.last
            @marked[question.match(/\A(.+):/)[0]] = @responses.last
          elsif marked.has_key?(question)
            @responses << marked[question]
            question = @responses.last
          else
            get_response(question)
            question = @responses.last
          end
        }
      end
    }
  end

  def get_response(question)
    puts question
    answer = gets.strip
    @responses << answer
  end

  def run
    puts "Here come the madlibs."
    get_answers
    #wrap_string
  end
end

filename = ARGV[0]
Madlib.new(filename).run
