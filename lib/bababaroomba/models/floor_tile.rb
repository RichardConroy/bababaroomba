# frozen_string_literal: true

require "bababaroomba"
require "bababaroomba/models/tile"

module Bababaroomba
  module Models
    # A Tile subclass that can be traversed by the dustbot, and which can contain objects
    class FloorTile < Tile
      attr_reader :contents

      def passable?
        true
      end

      def add_item(item)
        contents << item
      end

      def remove_item(item)
        contents.delete(item)
      end

      def glyph
        "."
      end
    end
  end
end
