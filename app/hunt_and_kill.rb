# frozen_string_literal: true

# A class which implements a constrained random walk algorithm.
# The algorithm is very similar to aldous broder.
class HuntAndKill
  def self.execute_on(grid)
    curr = grid.random_cell

    while curr
      unvisited_neighbours = curr.neighbours.select { |cell| cell.links.empty? }

      curr = if unvisited_neighbours.any?
               next_cell(grid, curr, unvisited_neighbours)
             else
               hunt_next_viable_cell(grid)
             end
    end
    grid
  end

  def self.next_cell(grid, curr, unvisited_neighbours)
    nxt = unvisited_neighbours.sample
    curr.link(nxt)
    nxt
  end

  def self.hunt_next_viable_cell(grid)
    # If there are no unvisited neighbours hunt for the first unvisited cell
    # which has an adjacent visited cell, and link them before starting the
    # path carving again.
    curr = nil
    grid.each_cell do |cell|
      visited_neighbours = cell.neighbours.select { |cell| cell.links.any? }
      next if visited_neighbours.empty? || cell.links.any?

      visited_cell = visited_neighbours.sample
      curr = cell
      curr.link(visited_cell)
      break
    end
    curr
  end

  private_class_method :next_cell, :hunt_next_viable_cell

end
