# frozen_string_literal: true
# rubocop:disable Metrics/ClassLength

require_relative 'cell'
require 'chunky_png'

# We need to be able to generate an empty grid in generate_grid.
# And also configure the cells by setting the cells in each of
# their cardinal directions in configure_grid.
# We also NEED to define a custom array accessor in [] so that
# if cells out of the bounds of the grid try to be accessed,
# null is returned.

# Random cell selection is in random_cell.
# The number of cells is in count.

# A class to represent a maze grid of cells.
class Grid
  attr_reader :rows, :columns

  def initialize(rows, columns)
    # Rows and columns hold the number of rows and columns.
    @rows = rows
    @columns = columns

    # Setup and configure the grid
    @grid = generate_grid
    configure_grid
  end

  def [](row, column)
    return nil unless row.between?(0, @rows - 1)
    return nil unless column.between?(0, @grid[row].count - 1)

    @grid[row][column]
  end

  # This is usually just a space and will be overridden in classes which want to display different information inside the cells.
  def contents_of(_cell)
    ' '
  end

  def background_of(_cell)
    nil
  end

  def to_s
    # The to string method will only look at north and east walls of each cell.
    out = +''
    each_row do |row|
      out << row_to_s(row)
    end
    bottom = "+#{'---+' * columns}"
    out << bottom

    out
  end

  # Cell size is in pixels.
  def to_png(cell_size: 10)
    width = cell_size * @columns
    height = cell_size * @rows

    background_colour = ChunkyPNG::Color::WHITE
    wall_colour = ChunkyPNG::Color::BLACK

    png = ChunkyPNG::Image.new(width + 1, height + 1, background_colour)

    %i[background lines].each do |mode| # Background first then lines
      each_cell do |cell|
        if mode == :lines
          draw_cell_lines(cell, cell_size, png, wall_colour)
        else # mode == :background
          cell_background_colour = background_of(cell)
          draw_cell_background(cell, cell_size, png, cell_background_colour) if cell_background_colour
        end
      end
    end

    png
  end

  def generate_grid
    Array.new(rows) do |row|
      Array.new(columns) do |column|
        Cell.new(row, column)
      end
    end
  end

  def each_row(&block)
    @grid.each(&block)
  end

  def each_cell(&block)
    each_row do |row|
      row.each(&block)
    end
  end

  def configure_grid
    each_cell do |cell|
      row = cell.row
      column = cell.column

      cell.north = self[row - 1, column]
      cell.east = self[row, column + 1]
      cell.south = self[row + 1, column]
      cell.west = self[row, column - 1]
    end
  end

  def random_cell
    rand_row = rand(@rows)
    rand_column = rand(@grid[rand_row].count)

    self[rand_row, rand_column]
  end

  def count
    @rows * @columns
  end

  def deadends
    deadends = []
    each_cell do |cell|
      deadends << cell if cell.links.count == 1
    end
    deadends
  end

  private

  def row_to_s(row)
    row_top = +'+'
    row_mid = +'|'
    row.each do |cell|
      rows = cell_to_s(cell, row_top, row_mid)
      row_top = rows['row_top']
      row_mid = rows['row_mid']
    end
    row_top << "\n" << row_mid << "\n"
  end

  def cell_to_s(cell, row_top, row_mid)
    row_top = row_top_to_s(cell, row_top)
    row_mid = row_mid_to_s(cell, row_mid)
    { 'row_top' => row_top, 'row_mid' => row_mid }
  end

  def row_top_to_s(cell, row_top)
    row_top << if cell.north
                 (cell.linked?(cell.north) ? '   +' : '---+')
               else
                 '---+'
               end
  end

  def row_mid_to_s(cell, row_mid)
    contents_of_cell = contents_of(cell)
    row_mid << if cell.east
                 (cell.linked?(cell.east) ? " #{contents_of_cell}  " : " #{contents_of_cell} |")
               else
                 " #{contents_of_cell} |"
               end
  end

  def draw_cell_lines(cell, cell_size, png, wall_colour)
    x1 = cell.column * cell_size
    y1 = cell.row * cell_size
    x2 = (cell.column + 1) * cell_size
    y2 = (cell.row + 1) * cell_size

    png.line(x1, y1, x2, y1, wall_colour) unless cell.linked?(cell.north)
    png.line(x2, y1, x2, y2, wall_colour) unless cell.linked?(cell.east)

    png.line(x1, y2, x2, y2, wall_colour) unless cell.south
    png.line(x1, y1, x1, y2, wall_colour) unless cell.west
    png
  end

  def draw_cell_background(cell, cell_size, png, background_colour)
    x1 = cell.column * cell_size
    y1 = cell.row * cell_size
    x2 = (cell.column + 1) * cell_size
    y2 = (cell.row + 1) * cell_size

    png.rect(x1, y1, x2, y2, background_colour, background_colour)
    png
  end

end
# rubocop:enable Metrics/ClassLength
