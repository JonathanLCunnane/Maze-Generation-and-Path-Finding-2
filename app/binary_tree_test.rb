require_relative 'binary_tree'
require_relative 'grid'

grid = Grid.new(4, 4)
BinaryTree.execute_on(grid)
puts grid