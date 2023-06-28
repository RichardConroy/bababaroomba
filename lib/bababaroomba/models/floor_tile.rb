# frozen_string_literal: true

require "bababaroomba"
require "bababaroomba/models/tile"
require "bababaroomba/models/null_tile"
require "bababaroomba/models/point"

module Bababaroomba
  module Models
    # A Tile subclass that can be traversed by the dustbot, and which can contain objects
    class FloorTile < Tile
      def passable?
        true
      end

      def add_item(item)
        raise ArgumentError, "only Item instances allowed" unless item.is_a? Item

        contents << item
        item.location = self
      end

      def remove_item(item)
        raise ArgumentError, "only Item instances allowed" unless item.is_a? Item

        contents.delete(item) { raise ArgumentError, "item was not present at this tile " }
        item.location = Bababaroomba::Models::NullTile.new(point: Point.new(-1001, -1001))
      end

      def glyph
        return "." if contents.empty?

        contents.min_by { |item| -item.z_order }.glyph
      end

      private

      def contents
        @contents ||= []
      end
    end
  end
end
