require "io/console"

VACUUM  = " "
VAPOR   = "."
FROST   = "*"
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

  attr_reader :grid

  def to_s
    grid.map { |row| row.join }.join("\n")
  end

  def frozen?
    false
  end

  def create_neighborhoods
    neighborhoods = Hash.new
    grid.each_with_index do |row, y|
      if y.even?
        row.each_with_index do |cell, x|
          if x.even?
            neighborhoods["n(#{x},#{y})"] = [[cell]]
            neighborhoods["n(#{x},#{y})"].first << grid[y][x + 1]
            neighborhoods["n(#{x},#{y})"] << [grid[y + 1][x]]
            neighborhoods["n(#{x},#{y})"].last << grid[y + 1][x + 1]
          end
        end
      end
    end
    return neighborhoods
  end

  def freeze_neighborhoods
    neighborhoods = create_neighborhoods
    neighborhoods.keys.each do |key|
      value = neighborhoods[key]
      if value.flatten.include?(FROST)
        neighborhoods[key].each_index do |y|
          neighborhoods[key][y].each_index do |x|
            if neighborhoods[key][y][x] == VAPOR
              neighborhoods[key][y][x] = FROST
            end
          end
        end
      end
    end
    return neighborhoods["n(46,22)"]
  end

  def tick
    freeze_neighborhoods
    #

  end

end

rows, cols = IO.console.winsize
screen = Grid.new(rows, cols)

#until screen.frozen?
#  puts screen
#  screen.tick
#  sleep 1
#end

p screen.freeze_neighborhoods
