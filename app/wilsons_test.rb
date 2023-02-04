# frozen_string_literal: true

require_relative 'wilsons'
require_relative 'grid'
require_relative 'direction'
require 'benchmark'


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
      Grid.new(100, 100)
    ]
  end
  grids.each do |grid|
    benchmark.report("#{grid.rows} x #{grid.columns}") { Wilsons.execute_on(grid) }
    out << "#{grid}\n\n" if grid.columns <= 25
    curr_time = time.strftime('%Y_%m_%d_%H_%M_%S')
    grid.to_png.save "./out/wilsons_#{curr_time}_#{grid.rows}_#{grid.columns}.png"
  end
end

puts "Wilson's benchmark finished."
puts "Grid pngs have been stored in the 'out' folder"
puts 'Grids for columns <= 25 are below:'
puts out
