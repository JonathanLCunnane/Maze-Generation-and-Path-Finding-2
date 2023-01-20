# frozen_string_literal: true

require_relative 'grid'


# A child class of grid that displays cell distances.
class DistanceGrid < Grid
  attr_accessor :distances

  def contents_of(cell)
    if distances && distances[cell]
      distances[cell].to_s(36)
    else
      super(cell)
    end
  end
end
