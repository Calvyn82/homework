require "io/console"

VACUUM  = " "
VAPOR   = "\e[34;1m.\e[0m"
FROST   = "\e[37;1m*\e[0m"
VAPOR_PERCENTAGE = 30

class Grid
  def initialize(rows, cols)
    @rows = rows - 1
    if @rows.odd?
      @rows -= 1
    end

    @cols = cols
    if @cols.odd?
      @cols -= 1
    end
    
    @grid = Array.new(@rows) { Array.new(@cols) {
      if rand(1..100) <= VAPOR_PERCENTAGE
        VAPOR
      else
        VACUUM
      end
    } }
    @grid[rows/2][cols/2] = FROST
  end

  attr_reader :grid, :rows, :cols

  def to_s
    grid.map { |row| row.join }.join("\n")
  end

  def frozen?
    false
  end

  def tick
    (0..(rows/2)).step(2) { |y| 
      (0..(cols/2)).step(2) { |x|
        neighborhood = Neighborhood.new(x, y, grid)
        if neighborhood.has_frost?
          neighborhood.freeze
        end
      }}
  end
end

class Neighborhood
  def initialize(x, y, grid)
    @x = x
    @y = y
    @grid = grid
  end

  attr_reader :x, :y, :grid

  def xys
    [[x,y], [x+1,y], [x,y+1], [x+1,y+1]]
  end

  def has_frost?
    xys.any? do |x, y|
      grid[y][x] == FROST
    end
  end

  def freeze
    xys.each do |x, y|
      if grid[y][x] == VAPOR
        grid[y][x] = FROST
      end
    end
  end
end

rows, cols = IO.console.winsize
screen = Grid.new(rows, cols)

until screen.frozen?
  puts screen
  screen.tick
  sleep 1
end

