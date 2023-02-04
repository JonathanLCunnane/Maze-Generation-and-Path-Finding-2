# frozen_string_literal: true

# A class which implements the Wilson's generation algorithm, a loop erased random walk algorithm.
# Wilson's is slow to start.
class Wilsons
  def self.execute_on(grid)
    unvisited = []
    grid.each_cell do |cell|
      unvisited << cell
    end

    initial = unvisited.sample
    unvisited.delete(initial)

    carve_path(unvisited) while unvisited.any?

    grid
  end

  def self.carve_path(unvisited)
    path = get_path(unvisited)

    0.upto(path.length - 2) do |idx|
      path[idx].link(path[idx + 1], bidirectional: true)
      unvisited.delete(path[idx])
    end
  end

  def self.get_path(unvisited)
    curr = unvisited.sample
    path = [curr]

    while unvisited.include?(curr)
      curr = curr.neighbours.sample
      idx = path.index(curr)
      path = modify_path(path, curr, idx)
    end
    path
  end

  def self.modify_path(path, curr, idx)
    if idx
      path[0..idx]
    else
      path << curr
    end
  end

  private_class_method :carve_path, :get_path, :modify_path
end
