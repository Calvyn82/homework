CORNER          = "+"
VERTICAL_WALL   = "|"
HORIZONTAL_WALL = "-"
SPACE           = " "

class Cell
  def initialize
    @north_wall = true
    @west_wall  = true
  end

  def north_wall?
    @north_wall
  end

  def west_wall?
    @west_wall
  end

  def north_wall
    if north_wall?
      HORIZONTAL_WALL
    else
      SPACE
    end
  end

  def west_wall
    if west_wall?
      VERTICAL_WALL
    else
      SPACE
    end
  end

  def remove_north_wall
    @north_wall = false
  end

  def remove_west_wall
    @west_wall = false
  end
end

class Grid
  def initialize(width, height)
    @width  = width
    @height = height
    
    @cells = Array.new(@height) { Array.new(@width) { Cell.new }}
  end

  attr_reader :width, :height, :cells

  def to_s
    string = ""
    cells.each do |row|
      row.each do |cell|
        string << CORNER << cell.north_wall
      end
      string << CORNER << "\n"
      row.each do |cell|
        string << cell.west_wall << SPACE
      end 
      string << VERTICAL_WALL << "\n"
    end
    string << "#{CORNER}#{HORIZONTAL_WALL}" * width << CORNER << "\n"
    string
  end
end

class MazeBuilder
  def initialize(grid)
    @grid = grid
  end

  attr_reader :grid
  
  def build
    grid.cells.each_with_index do |row, y|
      row.each_with_index do |cell, x|
        update_cell(x, y, cell)
        print "\e[2J\e[f"
        puts grid
        sleep 0.2
      end
    end
  end

  def update_cell(x, y, cell)
    if x == 0 && y == 0
      # do nothing
    elsif x == 0
      cell.remove_north_wall
    elsif y == 0
      cell.remove_west_wall
    else
      if rand(2) == 0
        cell.remove_north_wall
      else
        cell.remove_west_wall
      end
    end
  end
end
MazeBuilder.new(Grid.new(50, 20)).build
