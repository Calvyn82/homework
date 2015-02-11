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
    
    @cells = Array.new(@rows) { Array.new(@cols) {
      if rand(1..100) <= VAPOR_PERCENTAGE
        VAPOR
      else
        VACUUM
      end
    } }
    @cells[rows/2][cols/2] = FROST
  end

  attr_reader :cells, :rows, :cols

  def [](x,y)
    cells[y][x]
  end

  def []=(x, y, cell)
    cells[y][x] = cell
  end

  def to_s
    cells.map { |row| row.join }.join("\n")
  end

  def frozen?
    !cells.flatten.include?(VAPOR)
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
    [[x, y], [x+1, y], [x+1, y+1], [x, y+1]]
  end

  def has_frost?
    xys.any? do |x, y|
      grid[x, y] == FROST
    end
  end

  def freeze
    xys.each do |x, y|
      if grid[x, y] == VAPOR 
        grid[x, y] = FROST
      end
    end
  end
  
  def rotate
    tos = xys
    if rand(2) == 0   #clockwise rotation
      tos << tos.shift
    else              #count-clockwise rotation
      tos.unshift(tos.pop)
    end
    cels = xys.map { |x, y| grid[x, y] }
    cels.zip(tos) { |cell, (x, y)| grid[x, y] = cell }
  end
end

class Simulation
  def initialize(*args)
    @grid = Grid.new(*args)
    @tick_count = 1 
  end

  attr_reader :grid

  def tick
    ys = (0...grid.rows)
    xs = (0...grid.cols)
    if @tick_count.even?
      ys = Range.new(ys.begin - 1, ys.end - 1, ys.exclude_end?)
      xs = Range.new(xs.begin - 1, xs.end - 1, xs.exclude_end?)
    end
    ys.step(2) { |y| 
      xs.step(2) { |x|
        neighborhood = Neighborhood.new(x, y, grid)
        if neighborhood.has_frost?
          neighborhood.freeze
        else
          neighborhood.rotate
        end
      }}
    @tick_count += 1
  end

  def run
    until grid.frozen?
      puts grid
      tick
      sleep 0.3
    end
    puts grid
  end
end

Simulation.new(*IO.console.winsize).run
