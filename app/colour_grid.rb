# frozen_string_literal: true

require_relative 'grid'

# A class to generate a coloured grid from a set of distances.
class ColourGrid < Grid
  # We need to have a way of storing the max distance when the distances are given to the colour grid,
  # hence we write our own setter method.

  def distances=(distances)
    @distances = distances
    @max_distance = distances.max[1]
  end

  def background_of(cell)
    if @distances && @distances[cell]
      distance = @distances[cell]
      normalised_distance = distance.to_f / @max_distance
      normalised_closeness = 1 - normalised_distance
      r = (255 * normalised_closeness).round
      g = b = (126 + (normalised_closeness * 127)).round
      ChunkyPNG::Color.rgb(r, g, b)
    else
      super(cell)
    end
  end
end
