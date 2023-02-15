# frozen_string_literal: true

require_relative 'grid'

# A grid which implements masking functionality using the Mask class.
class MaskedGrid < Grid
  attr_reader :mask

  def initialize(mask)
    @mask = mask
    super(@mask.rows, @mask.columns)
  end

  def generate_grid
    Array.new(rows) do |row|
      Array.new(columns) do |column|
        Cell.new(row, column) if @mask[row, column]
      end
    end
  end

  def random_cell
    row, column = @mask.random_cell
    self[row, column]
  end

  def count
    @mask.enabled_count
  end
end
