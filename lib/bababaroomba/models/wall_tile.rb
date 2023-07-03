# frozen_string_literal: true

require "bababaroomba/models/tile"

module Bababaroomba
  module Models
    # Tile subclass that represents an impassible structure (unused)
    class WallTile < Tile
      def passable?
        false
      end

      def glyph
        "#"
      end
    end
  end
end
