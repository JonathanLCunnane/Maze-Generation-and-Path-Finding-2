# frozen_string_literal: true

require_relative 'direction'
require_relative 'distances'

# In our cell class, we want to be able to query the cells in the
# cardinal directions which are accessible in 'neighbours'
# We also want to be able to be able to retrieve the cell
# objects which are linked to the current cell in 'links'.
# Finally we want to be able to query whether a cell is
# accessible from the current cell in 'linked?'.
# We do the opposite for unlinking cells.
# We finally need to have a method for linking and unlinking
# cells in 'link' and 'unlink'

# A class representing a grid cell.
class Cell
  attr_reader :row, :column
  attr_accessor :north, :south, :east, :west

  def initialize(row, column)
    @row = row
    @column = column

    # The neighbours instance variable is
    # for holding the accessible neighbouring cells.
    @cell_links = {}
  end

  def neighbours
    directions = []
    directions << north if north
    directions << east if east
    directions << south if south
    directions << west if west
    directions
  end

  def cell_in_dir(dir)
    case dir
    when Direction.north
      north
    when Direction.east
      east
    when Direction.south
      south
    when Direction.west
      west
    end
  end

  def links
    @cell_links.keys
  end

  def linked?(cell)
    @cell_links.key?(cell)
  end

  def link(cell, bidirectional: true)
    @cell_links[cell] = true
    cell.link(self, bidirectional: false) if bidirectional
    self
  end

  def unlink(cell, bidirectional: true)
    @cell_links.delete(cell)
    cell.unlink(self, bidirectional: false) if bidirectional
    self
  end

  def distances
    distances = Distances.new(self)
    queue = [self]
    queue, distances = get_new_queue_and_distances(queue, distances) while queue.any?
    distances
  end

  private

  def get_new_queue_and_distances(queue, distances)
    next_queue = []
    queue.each do |cell|
      cell.links.each do |next_cell|
        next if distances[next_cell]

        next_queue << next_cell
        distances[next_cell] = distances[cell] + 1
      end
    end
    queue = next_queue
    [queue, distances]
  end
end
