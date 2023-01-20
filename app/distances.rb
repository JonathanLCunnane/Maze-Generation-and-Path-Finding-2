# frozen_string_literal: true

# Stores the distances from a certain cell.
class Distances
  def initialize(root_cell)
    @root = root_cell
    @cell_dists = {}
    @cell_dists[@root] = 0
  end

  def [](cell)
    @cell_dists[cell]
  end

  def []=(cell, distance)
    @cell_dists[cell] = distance
  end

  def cells
    @cell_dists.keys
  end
end
