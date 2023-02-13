# frozen_string_literal: true

# frozen_string_literal: true

require_relative 'aldous_broder'
require_relative 'binary_tree'
require_relative 'hunt_and_kill'
require_relative 'recursive_backtracker'
require_relative 'sidewinder'
require_relative 'wilsons'

require_relative 'grid'
require_relative 'direction'
require 'benchmark'

algs = [
  [AldousBroder.method(:execute_on), 'aldous_broder'],
  [BinaryTree.method(:execute_on), 'binary_tree'],
  [HuntAndKill.method(:execute_on), 'hunt_and_kill'],
  [RecursiveBacktracker.method(:execute_on), 'recursive_backtracker'],
  [Sidewinder.method(:execute_on), 'sidewinder'],
  [Wilsons.method(:execute_on), 'wilsons']
]
algs.each_with_index do |alg, idx|
  alg_name = alg[1]
  puts "#{idx + 1}. #{alg_name}"
end
puts "Enter a generation algorithm given by its corresponding number from 1 to #{algs.length}
(Note float inputs will be truncated.):"
alg_num = gets.chomp.to_i
abort("Input has to be in range 1..#{algs.length} and be an integer") if alg_num <= 0 || alg_num > algs.length

alg_idx = alg_num - 1
alg_method = algs[alg_idx][0]
alg_name = algs[alg_idx][1]
puts "Starting #{alg_name} benchmark."


out = +''
time = Time.new
Benchmark.bm(20) do |benchmark|
  grids = []
  benchmark.report('Generating Grids') do
    grids = [
      Grid.new(5, 5),
      Grid.new(10, 10),
      Grid.new(25, 25),
      Grid.new(50, 50),
      Grid.new(100, 100),
      Grid.new(250, 250)
    ]
  end
  grids.each do |grid|
    benchmark.report("#{grid.rows} x #{grid.columns}") { alg_method.call(grid) }
    out << "#{grid}\n\n" if grid.columns <= 25
    curr_time = time.strftime('%Y_%m_%d_%H_%M_%S')
    grid.to_png.save "./out/#{alg_name}_#{curr_time}_#{grid.rows}_#{grid.columns}.png"
  end
end

puts "#{alg_name} benchmark finished."
puts "Grid pngs have been stored in the 'out' folder"
puts 'Grids for columns <= 25 are below:'
puts out
