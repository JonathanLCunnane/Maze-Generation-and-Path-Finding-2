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
min_count = {}
max_count = {}
standard_deviation = {}
algs.each do |alg, name|
  puts "Analysing #{name}"

  counts = []
  min_count[name] = maze_size**2
  max_count[name] = 0

  repeats.times do
    grid = Grid.new(maze_size, maze_size)
    alg.call(grid)
    count = grid.deadends.size

    counts << count
    min_count[name] = count if count < min_count[name]
    max_count[name] = count if count > max_count[name]
  end

  avg = counts.sum / counts.size
  avg_count[name] = avg

  variance = counts.sum { |count| (count - avg)**2 } / counts.size
  standard_deviation[name] = variance**0.5
end

puts "\nBelow is the deadend analysis output for a #{maze_size}x#{maze_size} maze (#{maze_size**2} cells):"
puts "NOTE: The algorithms are sorted by the average number of deadends in descending order.\n\n"

sorted_count_arr = avg_count.sort_by { |_name, count| -count }
sorted_count_arr.each do |name, count|
  puts "#{name}:"

  avg_percentage = 100 * avg_count[name] / maze_size**2
  puts "Average # of deadends: #{avg_percentage}% #{count}/#{maze_size**2}"

  std_deviation_percentage = 100 * standard_deviation[name] / maze_size**2
  std_deviation_percentage = std_deviation_percentage.round
  standard_deviation[name] = standard_deviation[name].round
  puts "Standard deviation of # of deadends: #{std_deviation_percentage}% #{standard_deviation[name]}/#{maze_size**2}"

  max_percentage = 100 * max_count[name] / maze_size**2
  min_percentage = 100 * min_count[name] / maze_size**2
  print "Range of # of deadends: #{min_percentage}% to #{max_percentage}% "
  $stdout.flush
  puts "#{min_count[name]}/#{maze_size**2} to #{max_count[name]}/#{maze_size**2}\n\n"
end
