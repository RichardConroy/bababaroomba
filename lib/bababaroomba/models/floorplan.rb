require 'bababaroomba'
require 'bababaroomba/models/point'
require 'bababaroomba/models/floor_tile'
require 'bababaroomba/models/null_tile'
require 'bababaroomba/models/tile'
require 'pry'

module Bababaroomba
  module Models
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

      def find(x_coord,y_coord)
        tiles.fetch(Point.new(x_coord,y_coord))
      end

      def render
        (height - 1).downto(0) do |y_coord|
          row = 0.upto(width - 1).map { |x_coord| find(x_coord,y_coord) }
          puts row.map(&:glyph).join
        end
      end

      def self.generate_default(width=20, height=15)
        floorplan = Floorplan.new

        null_point = Point.new(-1001,-1001)

        x = width
        y = height

        0.upto(x - 1).each do |x_coord|
          0.upto(y - 1).each do |y_coord|
            point = Point.new(x_coord,y_coord)
            floor_tile = FloorTile.new(point: point)
            Tile::BOUNDARIES.each { |boundary| floor_tile.connect(NullTile.new(point: null_point), boundary) } # connect each new tile to void
            floorplan.tiles[point] = FloorTile.new(point: point)
          end
        end

        (0.upto(x - 2)).each do |x_coord|
          (0.upto(y - 2)).each do |y_coord|
            tile = floorplan.find(x_coord, y_coord)
            north_boundary = floorplan.find(x_coord, y_coord+1)
            east_boundary =  floorplan.find(x_coord+1, y_coord)
            tile.connect(north_boundary, :north)
            tile.connect(east_boundary, :east)
          end
        end
        floorplan
      end
    end
  end
end
