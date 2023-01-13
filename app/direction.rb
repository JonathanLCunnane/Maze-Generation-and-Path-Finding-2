# frozen_string_literal: true
require 'set'

# A class to represent the four cardinal directions.
class Direction
  def self.north
    'NORTH'
  end

  def self.east
    'EAST'
  end

  def self.south
    'SOUTH'
  end

  def self.west
    'WEST'
  end

  def self.opposites?(dir_one, dir_two)
    conditions = [
      [north, south],
      [south, north],
      [east, west],
      [west, east]
    ]
    conditions.include?([dir_one, dir_two])
  end
end
