require_relative 'cell'

# We need to be able to generate an empty grid in generate_grid.
# And also configure the cells by setting the cells in each of
# their cardinal directions in configure_grid.
# We also NEED to define a custom array accessor in [] so that
# if cells out of the bounds of the grid try to be accessed,
# null is returned.

# Random cell selection is in random_cell.
# The number of cells is in count.


class Grid
    attr_reader :rows, :columns

    def [](row, column)
        return nil unless row.between?(0, @rows-1)
        return nil unless column.between?(0, @grid[row].count-1)
        @grid[row][column]
    end

    def initialize(rows, columns)
        # Rows and columns hold the number of rows and columns.
        @rows = rows
        @columns = columns

        # Setup and configure the grid
        @grid = generate_grid
        configure_grid
    end

    def generate_grid
        Array.new(rows) do |row|
            Array.new(columns) do |column|
                Cell.new(row, column)
            end
        end
    end

    def each_row
        @grid.each do |row|
            yield row
        end
    end

    def each_cell
        each_row do |row|
            row.each do |cell|
                yield cell
            end
        end
    end

    def configure_grid
        each_cell do |cell|
            row, column = cell.row, cell.column

            cell.north = self[row-1, column]
            cell.east = self[row, column+1]
            cell.south = self[row+1, column]
            cell.west = self[row, column-1]
        end
    end

    def random_cell
        rand_row = rand(@rows)
        rand_column = rand(@grid[row].count)

        self[rand_row, rand_column]
    end

    def count
        @rows * @columns
    end

end