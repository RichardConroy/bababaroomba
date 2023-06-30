# frozen_string_literal: true

require "bababaroomba/models/connection"

module Bababaroomba
  module Models
    # Abstract base class implementation of a tile in a floorplan
    class Tile
      attr_reader :coords, :connections

      def initialize(point:)
        @coords = point
        @connections = []
      end

      def connect(connection)
        raise ArgumentError, "connection is required" unless connection
        raise ArgumentError, "must be a connection type" unless connection.is_a? Connection

        connections << connection
      end

      def passable?
        false
      end

      def glyph
        "X"
      end

      # TODO: delegate co-ordinates to stored point object
    end
  end
end
