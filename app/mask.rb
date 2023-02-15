# frozen_string_literal: true

# Stores a 2D array of bits.
# 'true' means a cell is enabled.
# 'false' means a cell is disabled.
class Mask
  attr_reader :rows, :columns

  def initialize(rows, columns)
    @rows = rows
    @columns = columns
    @enabled = Array.new(@rows) { Array.new(@columns, true) }
  end

  def [](row, column)
    return false unless row.between?(0, @rows - 1) || column.between?(0, @columns - 1)

    @enabled[row][column]
  end

  def []=(row, column, enabled)
    @enabled[row][column] = enabled
  end

  def enabled_count
    count = 0
    @enabled.each do |row|
      row.each do |cell|
        count += 1 if cell
      end
    end
    count
  end

  def random_cell
    loop do
      row = rand(@rows)
      column = rand(@columns)

      return [row, column] if @enabled[row][column]
    end
  end
end
