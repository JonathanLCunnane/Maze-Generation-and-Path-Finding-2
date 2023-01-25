# frozen_string_literal: true

require_relative 'distance_grid'
require_relative 'sidewinder'


grid = DistanceGrid.new(7, 7)
Sidewinder.execute_on(grid)

puts 'Empty grid:'
puts grid

root = grid[0, 0]
distances = root.distances
grid.distances = distances
puts "\n\nDistances from root = [0, 0]:"
puts grid

# To find the longest path in a maze run dijkstra twice like shown.
start_cell = distances.max[0]
distances_from_start = start_cell.distances
end_cell, max_grid_dist = distances_from_start.max
grid.distances = distances_from_start.path_to(end_cell)
puts "\n\nLongest path in grid (with a distance of #{max_grid_dist}): "
puts grid
