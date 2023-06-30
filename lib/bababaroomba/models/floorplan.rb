# frozen_string_literal: true

require "bababaroomba/models/point"
require "bababaroomba/models/floor_tile"
require "bababaroomba/models/null_tile"
require "bababaroomba/models/tile"
require "pry"

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

      # TODO: move all this setup into a floorplan generator
      def self.generate_default(width = 20, height = 15)
        floorplan = Floorplan.new
        create_grid_tiles(width, height, floorplan)
        # 0.upto(width - 2).each do |x_coord|
        #   0.upto(height - 2).each do |y_coord|
        #     connect_tiles(floorplan, x_coord, y_coord)
        #   end
        # end
        floorplan
      end

      def self.create_grid_tiles(width, height, floorplan)
        0.upto(width - 1).each do |x_coord|
          0.upto(height - 1).each do |y_coord|
            point = Point.new(x_coord, y_coord)
            floorplan.tiles[point] = FloorTile.new(point: point)
          end
        end
      end

      def self.connect_tiles(floorplan, x_coord, y_coord)
        tile = floorplan.find(x_coord, y_coord)
        north_boundary = floorplan.find!(x_coord, y_coord + 1)
        east_boundary =  floorplan.find!(x_coord + 1, y_coord)
        Connection.create north_boundary, tile
        Connection.create east_boundary, tile
      end

      def self.null_point
        @null_point ||= Point.new(-1001, -1001)
      end
    end
  end
end
