# frozen_string_literal: true

require_relative 'grid'

require_relative 'aldous_broder'
require_relative 'binary_tree'
require_relative 'hunt_and_kill'
require_relative 'recursive_backtracker'
require_relative 'sidewinder'
require_relative 'wilsons'

algs = [
  [AldousBroder.method(:execute_on), 'aldous_broder'],
  [BinaryTree.method(:execute_on), 'binary_tree'],
  [HuntAndKill.method(:execute_on), 'hunt_and_kill'],
  [RecursiveBacktracker.method(:execute_on), 'recursive_backtracker'],
  [Sidewinder.method(:execute_on), 'sidewinder'],
  [Wilsons.method(:execute_on), 'wilsons']
]

puts "Enter the maze size to be used from 10 to 50
(Note float inputs will be truncated.):"
maze_size = gets.chomp.to_i
abort('Input has to be in range 10..50 and be an integer') if maze_size < 10 || maze_size > 50

repeats = 100

avg_count = {}
algs.each do |alg, name|
  puts "Analysing #{name}"

  counts = []
  repeats.times do
    grid = Grid.new(maze_size, maze_size)
    alg.call(grid)
    counts << grid.deadends.count
  end

  avg = counts.sum / counts.count
  avg_count[name] = avg
end

puts "The sorted average deadends for a #{maze_size}x#{maze_size} maze (#{maze_size**2} cells) is:\n\n"

sorted_count_arr = avg_count.sort_by { |_name, count| -count }
sorted_count_arr.each do |name, count|
  percentage = 100 * avg_count[name] / maze_size**2
  puts "#{name} #{percentage}% #{count}/#{maze_size**2}"
end