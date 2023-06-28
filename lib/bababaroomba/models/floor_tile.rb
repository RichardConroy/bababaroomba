require 'bababaroomba'
require 'bababaroomba/models/tile'

module Bababaroomba
  module Models
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
        '.'
      end
    end
  end
end
