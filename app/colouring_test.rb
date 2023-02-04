# frozen_string_literal: true

require_relative 'colour_grid'
require_relative 'binary_tree'
require_relative 'sidewinder'
require_relative 'aldous_broder'
require_relative 'wilsons'

def get_and_save_png(generation_alg, alg_name)
  grid = ColourGrid.new(75, 75)
  generation_alg.call(grid)
  start = grid[grid.rows / 2, grid.columns / 2]
  grid.distances = start.distances

  time = Time.new
  curr_time = time.strftime('%Y_%m_%d_%H_%M_%S')
  grid.to_png.save "./out/#{alg_name}_colouring_test_#{curr_time}_#{grid.rows}_#{grid.columns}.png"
end

puts 'Enter the iterations of each generation algorithm (25 >= inp >= 1):'
iters = gets.chomp.to_i
abort('Input has to be in range 1..25 and be an integer') if iters <= 0 || iters > 25
puts 'Progress:'

1.upto(iters) do |iter|
  [
    [Sidewinder.method(:execute_on), 'sidewinder'],
    [BinaryTree.method(:execute_on), 'binary_tree'],
    [AldousBroder.method(:execute_on), 'aldous_broder'],
    [Wilsons.method(:execute_on), 'wilsons']
  ].each do |generation_alg, alg_name|
    get_and_save_png(generation_alg, alg_name)
  end
  puts "#{(iter.to_f / iters * 100).round}%"
end
puts 'DONE'

puts "Grid pngs have been stored in the 'out' folder"
