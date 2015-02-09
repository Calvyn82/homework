class Square
  LETTERS = ["A", "B", "C", "D", "E", "F", "G", "H"]
  OFFSETS = [[1,2], [1, -2], [-1, 2], [-1, -2], [2, 1], [2, -1], [-2, 1], [-2, -1]]
  
  def initialize(*args)
    if args.size > 1
      @x        = args.first
      @y        = args.last
    else
      @x        = LETTERS.index(args.first[0])
      @y        = args.first[1].to_i - 1
    end
  end
  
  attr_reader :x, :y

  def moves
    OFFSETS
      .map { |offset| Square.new(x + offset.first, y + offset.last) }
      .select { |square| square.on_the_board? }
  end

  def on_the_board?
    x.between?(0, 7) && y.between?(0, 7)
  end

  def ==(square)
    x == square.x && y == square.y
  end

  def to_s
    "#{LETTERS[x]}#{y + 1}"
  end
end

class Path
  def initialize(*squares)
    @squares = squares
  end

  attr_reader :squares
  
  def to_s
    squares.join(", ")
  end

  def grow
    squares.last.moves.map { |move| Path.new(*squares, move) }
  end

  def ends_at?(square)
    squares.last == square
  end
end

class Pathfinder
  def initialize(start, finish)
    @start  = Square.new(start)
    @finish = Square.new(finish)
  end

  attr_reader :start, :finish

  def solve
    walk    = [Path.new(start)]
    while !walk.any? { |path| path.ends_at?(finish) }
      walk = walk.flat_map { |path| path.grow }
    end
    return walk.find { |path| path.ends_at?(finish) }
  end
end

start   = ARGV[0]
finish  = ARGV[1]
puts Pathfinder.new(start, finish).solve
