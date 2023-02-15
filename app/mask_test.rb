# frozen_string_literal: true

require_relative 'masked_grid'
require_relative 'mask'
require_relative 'recursive_backtracker'

mask = Mask.new(5, 5)

mask[1, 1] = false
mask[1, 2] = false
mask[1, 3] = false

grid = MaskedGrid.new(mask)

RecursiveBacktracker.execute_on(grid)

puts grid
