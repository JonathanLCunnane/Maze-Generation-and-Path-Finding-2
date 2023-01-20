# frozen_string_literal: true

require_relative 'distance_grid'
require_relative 'sidewinder'


grid = DistanceGrid.new(10, 10)
Sidewinder.execute_on(grid)

root = grid[0, 0]
grid.distances = root.distances
puts grid
