# frozen_string_literal: true

require_relative 'mask'
require_relative 'masked_grid'
require_relative 'recursive_backtracker'
require_relative 'distances'

abort 'Image mask .png file must be provided in args' if ARGV.empty?

mask = Mask.from_png(ARGV.first)
grid = MaskedGrid.new(mask)
RecursiveBacktracker.execute_on(grid)

time = Time.new
curr_time = time.strftime('%Y_%m_%d_%H_%M_%S')
out = "./out/recursive_backtracker_image_mask_test_#{curr_time}_#{grid.rows}_#{grid.columns}.png"

grid.to_png.save(out)
puts "Uncoloured grid saved to 'out' folder"

start = grid.random_cell
distances = start.distances
grid.distances = distances

curr_time = time.strftime('%Y_%m_%d_%H_%M_%S')
out = "./out/recursive_backtracker_image_mask_coloured_test_#{curr_time}_#{grid.rows}_#{grid.columns}.png"
grid.to_png.save(out)
puts "Coloured grid saved to 'out' folder"
