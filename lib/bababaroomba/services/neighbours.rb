# frozen_string_literal: true

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
    end
  end
end
