# frozen_string_literal: true

# A class to implement the recursive backtracker algorithm.
class RecursiveBacktracker
  def self.execute_on(grid)
    start = grid.random_cell

    stack = []
    stack.push(start)

    iterate_stack(stack) while stack.any?

    grid
  end

  def self.iterate_stack(stack)
    curr = stack.last
    unvisited_neighbours = curr.neighbours.select { |neighbour| neighbour.links.empty? }

    if unvisited_neighbours.empty?
      stack.pop
      return
    end

    next_cell = unvisited_neighbours.sample
    curr.link(next_cell)
    stack.push(next_cell)
  end

  private_class_method :iterate_stack
end
