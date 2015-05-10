class Builder
  def pull(key)
    array = Array.new
    File.open("data/#{key}.txt", "r") do |f|
      while (line = f.gets)
        array << line.strip
      end
    end
  return array
  end

  def build_questions
    array  = Array.new
    File.open("data/questions.txt", "r") do |f|
      while (line = f.gets)
        array << f.gets.strip
        f.gets.strip
      end
    end
    return array
  end

  def tag_questions(table)
    array     = Array.new
    hash      = Hash.new
    questions = build_questions
    File.open("data/questions.txt", "r") do |f|
      while (line = f.gets)
        f.gets.strip
        array << f.gets.strip
      end
    end
    questions.each do |question|
      hash[question] = table[array[questions.index(question)]]
    end
    return hash
  end

  def compare
    array     = Array.new
    hash      = Hash.new
    questions = build_questions
    File.open("data/questions.txt", "r") do |f|
      while (line = f.gets)
        f.gets.strip
        array << f.gets.strip
      end
    end
    questions.each do |question|
      hash[question] = array[questions.index(question)]
    end
    return hash
  end

  def run
    array = pull("directory")
    hash = Hash.new
    array.each do |key|
      hash[key] = pull(key)
    end
    hash["questions"] = build_questions
    return hash
  end
end

class Runner
  def initialize(animals, master_list, table, master_tables)
    @animals        = animals
    @master_list    = master_list
    @table          = table
    @master_tables  = master_tables
  end
    
  def yes(question)
    @animals.delete_if { |animal| !@master_tables[question].include?(animal) }
    return @animals
  end

  def no(question)
    @animals.delete_if { |animal| @master_tables[question].include?(animal) }
    return @animals
  end
  
  def check_questions
    check_questions = Builder.new
    check_questions = check_questions.tag_questions(@table)
    check = "no"
    while check == "no"
      question = @table["questions"].sample
      @animals.each do |animal|
        if check_questions[question].include?(animal)
          check = "yes"
        end
      end
    end
    return question
  end

  def question_loop(answer_tracking)
    while @animals.size > 1
      question = check_questions
      p question
      @table["questions"].delete(question)
      answer = gets.strip
      answer_tracking[question] = answer
      if answer == "yes"
        @animals = yes(question)
      elsif answer == "no"
        @animals = no(question)
      else
        puts "Oops! I didn't understand your response. Please start again."
        exit
      end
    end
    puts "Is your animal a(n) #{@animals.last}?"
    return answer_tracking
  end

  def oops
    puts "Oops! I didn't understand your response. Please start again."
    exit
  end

  def send_questions_data(response)
    i         = 1
    file_name = response["animal"]
    File.open("data/questions.txt", "a") do |f|
      f.puts
      f.puts response["question"]
      while File.exist?("data/#{file_name}")
        file_name = "#{response["animal"]}#{i}"
        i         = i + 1
      end
      f.puts file_name
    end
    return file_name
  end

  def run
    answer_tracking = Hash.new
    puts "Think of an animal."
    puts "Please answer all questions with 'yes' or 'no'."
    puts "Is your animal a category, such as horse, cat, mouse? (As opposed to a particular breed or species)"
    category = gets.strip
    if category == "yes"
      answer_tracking["category"] = category
      @animals.delete_if { |animal| !@table["category"].include?(animal) }
      answer_tracking = question_loop(answer_tracking)    
    elsif category == "no"
      answer_tracking["category"] = category
      puts "Is it a breed?"
      breed = gets.strip
      if breed == "yes"
        answer_tracking["breed"] = breed
        @animals.delete_if { |animal| !@table["breed"].include?(animal) }
        answer_tracking = question_loop(answer_tracking)
      elsif breed == "no"
        answer_tracking["breed"] = breed
        @animals.delete_if { |animal| !@table["species"].include?(animal) }
        answer_tracking = question_loop(answer_tracking)
      else
        oops
      end
    else
      oops
    end
    answer = gets.strip
    if answer == "yes"
      puts "Sweet. Thanks for playing."
    elsif answer == "no"
      puts "Aw, <expletive deleted>. How about you help me out so I can get smarter. It'll only take a minute."
      response = Hash.new
      puts "What kind of animal where you thinking of?"
      animal = gets.strip
      response["animal"] = animal
      puts "Please type a question that has a 'yes' answer that might help distinguish your animal from the one I guessed."
      question = gets.strip
      response["question"] = question
      puts "Thanks for playing."
      file_name = send_questions_data(response)
      check_locations = Builder.new
      check_locations = check_locations.compare
      if answer_tracking["category"] == "yes"
        File.open("data/category.txt", "a") { |f| f.puts response["animal"] }
      elsif
        answer_tracking["breed"] == "yes"
        File.open("data/breed.txt", "a") { |f| f.puts response["animal"] }
      elsif answer_tracking["breed"] == "no"
        File.open("data/species.txt", "a") { |f| f.puts response["animal"] }
      end
      answer_tracking.each do |question, answer|
        if answer == "yes"
          File.open("data/#{check_locations[question]}.txt", "a") { |f| f.puts response["animal"] }
        end
      end
      if !@master_list.include?(response["animal"])
        File.open("data/animal.txt", "a") { |f| f.puts response["animal"] }
      end
      File.open("data/directory.txt", "a") { |f| f.puts file_name }
      File.open("data/#{file_name}.txt", "a") { |f| f.puts response["animal"] }
    else
      oops
    end
  end
end

animals         = Builder.new
animals         = animals.pull("animal")
master_list     = animals.dup
table           = Builder.new
table           = table.run
master_tables   = Builder.new
master_tables   = master_tables.tag_questions(table)
guess           = Runner.new(animals, master_list, table, master_tables)
guess.run
