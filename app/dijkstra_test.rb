# frozen_string_literal: true

require_relative 'distance_grid'
require_relative 'sidewinder'


grid = DistanceGrid.new(8, 8)
Sidewinder.execute_on(grid, 0.75)

root = grid[0, 0]
distances = root.distances
grid.distances = distances
puts grid

grid.distances = distances.path_to(grid[7, 0])
puts grid
