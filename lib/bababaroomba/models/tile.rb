module Bababaroomba

  class Tile
    # Representation of a grid tile

    attr_reader :coords, :connections
    BOUNDARIES = [:north, :south, :east, :west].freeze

    def initialize(point:)
      @coords = point
      @connections = {}
    end

    def connect(connection, boundary)
      raise ArgumentError, "connection is required" unless connection
      raise ArgumentError, "boundary must be one of #{BOUNDARIES.join(' ')}" unless BOUNDARIES.include? boundary
      connections[boundary] = connection
    end

    def passable?
      false
    end

    def glyph
      'X'
    end

    #TODO: delegate co-ordinates to stored point object

    private

    def opposite(boundary)
      case boundary
      when :north
        :south
      when :south
        :north
      when :east
        :west
      when :west
        :east
      else
        raise ArgumentError, "#{boundary} - must be one of: #{BOUNDARIES.join}"
      end
    end
  end
end
