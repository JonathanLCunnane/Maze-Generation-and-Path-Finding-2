# frozen_string_literal: true

require_relative 'binary_tree'
require_relative 'grid'
require_relative 'direction'
require 'benchmark'


out = +''
Benchmark.bm(20) do |benchmark|
  grids = []
  benchmark.report('Generating Grids') do
    grids = [
      Grid.new(5, 5),
      Grid.new(10, 10),
      Grid.new(25, 25),
      Grid.new(50, 50),
      Grid.new(100, 100),
      Grid.new(250, 250),
      Grid.new(500, 500),
      Grid.new(1000, 1000),
      Grid.new(2500, 2500)
    ]
  end
  grids.each do |grid|
    benchmark.report("#{grid.rows} x #{grid.columns}") { BinaryTree.execute_on(grid) }
    out << "#{grid}\n\n" if grid.columns <= 25
  end
end

puts 'Binary tree benchmark finished.'
puts 'Grids for columns <= 25 are below:'
puts out
