# frozen_string_literal: true

require "bababaroomba/models/point"
require "bababaroomba/models/floorplan"
require "bababaroomba/models/floor_tile"

module Bababaroomba
  module Services
    # A service class to generate rectangular floorplans with dirt - practical alternative to floorplan initializer
    class FloorplanGenerator
      class << self
        def call(**args)
          new(**args).call
        end
      end

      def call
        @floorplan = Bababaroomba::Models::Floorplan.new
        create_grid_tiles
        make_it_messy
        @floorplan
      end

      private

      attr_accessor :width, :height, :dirt

      def initialize(width: 6, height: 5, dirt: 3)
        @width = width
        @height = height
        @dirt = dirt
      end

      def create_grid_tiles
        0.upto(width - 1).each do |x_coord|
          0.upto(height - 1).each do |y_coord|
            point = Bababaroomba::Models::Point.new(x_coord, y_coord)
            @floorplan.tiles[point] = Bababaroomba::Models::FloorTile.new(point: point)
          end
        end
      end

      def make_it_messy
        @floorplan.tiles
                  .values
                  .select(&:passable?)
                  .sample(dirt)
                  .each { |tile| tile.add_item(Bababaroomba::Models::Dirt.new) }
      end
    end
  end
end
