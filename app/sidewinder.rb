# frozen_string_literal: true

require_relative 'grid'
require_relative 'direction'

# The run_dir is the run direction, and is the direction in which the sidewinder algorithm
# carves if that is the chosen direction. In the closing_dir, when a run is ending,
# the closing_dir is the direction in which one carve is made along the length of the run.

# A class to implement the sidewinder generation algorithm.
# ONLY DEFAULT GRID RUN AND CLOSE IS IMPLEMENTED. DO NOT CHANGE RUN_DIR AND CLOSING_DIR.
class Sidewinder
  # Bias is the probability that run_dir is chosen.
  def self.execute_on(grid, bias = 0.5, run_dir = Direction.east, closing_dir = Direction.north)
    raise_dir_error(run_dir, closing_dir)
    # If the run direction is east or west, the algorithm is the same.
    # The same can be said for a north or south run direction.
    if run_dir == Direction.east || run_dir == Direction.west
      lateral_grid_run(grid, bias, run_dir, closing_dir)
    else
      longitudinal_grid_run(grid, bias, run_dir, closing_dir)
    end
    grid
  end

  def self.lateral_grid_run(grid, bias, run_dir, closing_dir)
    # We need to reverse the array if we are going in the west direction.
    grid.each_row do |row|
      # Run has to be reset every row.
      run = []
      row.each do |cell|
        run << cell
        choose_carve(bias, cell, run, run_dir, closing_dir)
      end
    end
    # ... and then reverse it back.
    # grid.reverse_grid if run_dir == Direction.west
  end

  def self.longitudinal_grid_run(grid, bias, run_dir, closing_dir)
    # To run the algorithm longitudinally, run the algorithm laterally.
    # Then transpose the grid.
    # lateral_grid_run(grid, bias, Direction.opposite(closing_dir), Direction.opposite(run_dir))
    # grid.transpose_grid
    lateral_grid_run(grid, bias, run_dir, closing_dir)
  end

  def self.choose_carve(bias, cell, run, run_dir, closing_dir)
    # First check if the run is ending and end run if so
    run_ended = false
    if rand > bias
      # If run_end was not successful, then we need to try to
      # carve out the run_dir wall for the current cell.
      run_ended = run_end(run, run_dir, closing_dir)
      run.clear
    end
    return if run_ended

    # Otherwise carve in run_dir
    try_carve(cell, run_dir, closing_dir)
  end

  def self.run_end(run_cells, run_dir, closing_dir)
    cell = run_cells.sample
    try_carve(cell, closing_dir, run_dir)
  end

  # Tries to carve in dir_one, and then dir_two. Returns true if dir_one was successful
  def self.try_carve(cell, dir_one, dir_two)
    cell_in_dir_one = cell.cell_in_dir(dir_one)
    cell_in_dir_two = cell.cell_in_dir(dir_two)
    success = false
    if cell_in_dir_one
      cell.link(cell_in_dir_one)
      success = true
    elsif cell_in_dir_two
      cell.link(cell_in_dir_two)
    end
    success
  end

  def self.raise_dir_error(dir_one, dir_two)
    raise "'dir_one' cannot equal 'dir_two'" if dir_one == dir_two
    raise "'dir_one cannot be opposite to 'dir_two" if Direction.opposites?(dir_one, dir_two)
  end

  private_class_method :raise_dir_error, :lateral_grid_run, :longitudinal_grid_run, :run_end
end
