# frozen_string_literal: true

# A class which implements the Aldous-Broder unbiased, random generation algorithm.
class AldousBroder
  def self.execute_on(grid)
    curr_cell = grid.random_cell
    to_visit = grid.count - 1
    while to_visit.positive?
      next_cell = curr_cell.neighbours.sample

      to_visit -= 1 if link_if_unvisited(curr_cell, next_cell)

      curr_cell = next_cell
    end

    grid
  end

  def self.link_if_unvisited(curr_cell, next_cell)
    if next_cell.links.empty?
      curr_cell.link(next_cell)
      true
    else
      false
    end
  end

  private_class_method :link_if_unvisited

end
