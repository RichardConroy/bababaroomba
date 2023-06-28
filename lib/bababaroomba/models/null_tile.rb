# frozen_string_literal: true

module Bababaroomba
  module Models
    # Null object representation of the edge of the map. Border tiles for connections with this.
    class NullTile < Tile
      def passable?
        false
      end

      def glyph
        " "
      end
    end
  end
end
