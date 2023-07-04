# frozen_string_literal: true

require "bababaroomba/error"
require "bababaroomba/models/point"
module Bababaroomba
  module Services
    # Locate the neighbours of a tile in the floorplan
    class Neighbours
      class << self
        def call(**args)
          new(**args).call
        end
      end

      def initialize(floorplan:, tile:)
        @floorplan = floorplan
        @tile = tile
      end

      def call # rubocop:disable Metrics/AbcSize
        raise_when_floorplan_does_not_contain_tile!
        x_coord = tile.coords.x
        y_coord = tile.coords.y
        [
          floorplan.find(x_coord, y_coord + 1),
          floorplan.find(x_coord, y_coord - 1),
          floorplan.find(x_coord + 1, y_coord),
          floorplan.find(x_coord - 1, y_coord)
        ].compact
      end

      private

      attr_accessor :floorplan, :tile

      def raise_when_floorplan_does_not_contain_tile!
        x_coord = tile.coords.x
        y_coord = tile.coords.y
        floorplan.find!(x_coord, y_coord)
      rescue KeyError
        raise Bababaroomba::Error, "Tile: [#{[x_coord, y_coord]}] not part of floorplan"
      end
    end
  end
end
