# frozen_string_literal: true

require_relative 'colour_grid'
require_relative 'binary_tree'
require_relative 'sidewinder'
require_relative 'aldous_broder'

def get_and_save_png(generation_alg, alg_name)
  grid = ColourGrid.new(75, 75)
  generation_alg.call(grid)
  start = grid[grid.rows / 2, grid.columns / 2]
  grid.distances = start.distances

  time = Time.new
  curr_time = time.strftime('%Y_%m_%d_%H_%M_%S')
  grid.to_png.save "./out/#{alg_name}_colouring_test_#{curr_time}_#{grid.rows}_#{grid.columns}.png"
end

[
  [Sidewinder.method(:execute_on), 'sidewinder'],
  [BinaryTree.method(:execute_on), 'binary_tree'],
  [AldousBroder.method(:execute_on), 'aldous_broder']
].each do |generation_alg, alg_name|
  get_and_save_png(generation_alg, alg_name)
end

puts "Grid pngs have been stored in the 'out' folder"
