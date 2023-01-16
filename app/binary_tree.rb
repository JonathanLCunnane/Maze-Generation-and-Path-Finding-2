# frozen_string_literal: true

require_relative 'grid'
require_relative 'direction'

# In our Binary Tree algorithm, iterating over each cell,
# you choose one of two directions (hence binary). In the
# classical implementation, these two directions are north and east.
# Bias is a number between 0 and 1 determining the probability that
# dir_one is chosen.

# A class to implement the binary tree generation algorithm.
class BinaryTree
  # Bias is the probability that dir_one is chosen.
  def self.execute_on(grid, bias = 0.5, dir_one = Direction.north, dir_two = Direction.east)
    raise_dir_error(dir_one, dir_two)
    grid.each_cell do |cell|
      cell_in_dir_one = cell.cell_in_dir(dir_one)
      cell_in_dir_two = cell.cell_in_dir(dir_two)
      select_and_link(cell, cell_in_dir_one, cell_in_dir_two, bias)
    end
    grid
  end

  def self.raise_dir_error(dir_one, dir_two)
    raise "'dir_one' cannot equal 'dir_two'" if dir_one == dir_two
    raise "'dir_one cannot be opposite to 'dir_two" if Direction.opposites?(dir_one, dir_two)
  end

  def self.select_and_link(cell, cell_in_dir_one, cell_in_dir_two, bias)
    if rand < bias
      try_link(cell, cell_in_dir_one, cell_in_dir_two)
    else
      try_link(cell, cell_in_dir_two, cell_in_dir_one)
    end
  end

  def self.try_link(cell, cell_priority, cell_secondary)
    if cell_priority
      cell.link(cell_priority)
    elsif cell_secondary
      cell.link(cell_secondary)
    end
  end

  private_class_method :raise_dir_error, :select_and_link, :try_link
end
