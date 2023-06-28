# frozen_string_literal: true

module Bababaroomba
  module Models
    # Abstract base class implementation of a tile in a floorplan
    class Tile
      attr_reader :coords, :connections

      BOUNDARIES = %i[north south east west].freeze
      OPPOSITES = {
        north: :south,
        south: :north,
        east: :west,
        west: :east
      }.freeze

      def initialize(point:)
        @coords = point
        @connections = {}
      end

      def connect(connection, boundary)
        raise ArgumentError, "connection is required" unless connection
        raise ArgumentError, "boundary must be one of #{BOUNDARIES.join(" ")}" unless BOUNDARIES.include? boundary

        connections[boundary] = connection
      end

      def passable?
        false
      end

      def glyph
        "X"
      end

      # TODO: delegate co-ordinates to stored point object

      private

      def opposite(boundary)
        OPPOSITES.fetch(boundary)
      end
    end
  end
end
