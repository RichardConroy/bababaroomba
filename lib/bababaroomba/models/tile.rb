# frozen_string_literal: true

module Bababaroomba
  module Models
    # Abstract base class implementation of a tile in a floorplan
    class Tile
      attr_reader :coords, :connections

      def initialize(point:)
        @coords = point
        @connections = []
      end

      def passable?
        false
      end

      def glyph
        "X"
      end
    end
  end
end
