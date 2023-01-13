# frozen_string_literal: true

require_relative 'binary_tree'
require_relative 'grid'
require_relative 'direction'
require 'benchmark'


Benchmark.bm(20) do |benchmark|
  grids = []
  benchmark.report('Generating Grids') do
    grids = [
      Grid.new(50, 50),
      Grid.new(100, 100),
      Grid.new(250, 250),
      Grid.new(500, 500),
      Grid.new(1000, 1000),
      Grid.new(2500, 2500)
    ]
  end
  grids.each do |grid|
    benchmark.report('%<grid.rows>d x %<grid.columns>d') { BinaryTree.execute_on(grid) }
  end
end

puts 'Binary tree benchmark finished.'
