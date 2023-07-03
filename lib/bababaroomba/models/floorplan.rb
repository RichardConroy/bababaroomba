# frozen_string_literal: true

require "bababaroomba/models/point"
require "bababaroomba/models/floor_tile"
require "bababaroomba/models/null_tile"
require "bababaroomba/models/tile"

module Bababaroomba
  module Models
    # Representation of a 2 dimensional room
    class Floorplan
      attr_reader :tiles

      def initialize
        @tiles = {}
      end

      def width
        tiles.keys.map(&:x).max + 1
      end

      def height
        tiles.keys.map(&:y).max + 1
      end

      def find(x_coord, y_coord)
        tiles[Point.new(x_coord, y_coord)]
      end

      def find!(x_coord, y_coord)
        tiles.fetch(Point.new(x_coord, y_coord))
      end

      def render
        (height - 1).downto(0) do |y_coord|
          row = 0.upto(width - 1).map { |x_coord| find!(x_coord, y_coord) }
          puts row.map(&:glyph).join
        end
      end
    end
  end
end
