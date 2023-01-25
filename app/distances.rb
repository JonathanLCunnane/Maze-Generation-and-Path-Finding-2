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

  def path_to(goal_cell)
    current_cell = goal_cell

    path = Distances.new(@root)
    path[current_cell] = @cell_dists[current_cell]

    current_cell, path = backtrack_once(current_cell, path) until current_cell == @root

    path
  end

  def max
    max_dist = 0
    max_cell = @root

    @cell_dists.each do |cell, dist|
      if dist > max_dist
        max_dist = dist
        max_cell = cell
      end
    end

    [max_cell, max_dist]
  end

  private

  def backtrack_once(current_cell, path)
    current_cell.links.each do |next_cell|
      if @cell_dists[next_cell] < @cell_dists[current_cell]
        path[next_cell] = @cell_dists[next_cell]
        return [next_cell, path]
      end
    end
  end
end
