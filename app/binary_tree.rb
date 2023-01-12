require_relative 'grid'
require_relative 'direction'

# In our Binary Tree algorithm, iterating over each cell,
# you choose one of two directions (hence binary). In the 
# classical implementation, these two directions are north and east.
# Bias is a number between 0 and 1 determining the probability that
# dir_one is chosen.

class BinaryTree

    def self.execute_on(grid, dir_one=Direction.north, dir_two=Direction.east, bias=0.5)
        raise "'dir_one' cannot equal 'dir_two'" if dir_one == dir_two
        count = 0
        grid.each_cell do |cell|
            cell_in_dir_one = cell.cell_in_dir(dir_one)
            cell_in_dir_two = cell.cell_in_dir(dir_two)
            if rand() < bias            
                cell_in_dir_one ? cell.link(cell_in_dir_one) : (cell.link(cell_in_dir_two) if cell_in_dir_two)
            else             
                cell_in_dir_two ? cell.link(cell_in_dir_two) : (cell.link(cell_in_dir_one) if cell_in_dir_one)
            end

        end
        
        grid
    end
end