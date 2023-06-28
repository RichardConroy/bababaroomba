# frozen_string_literal: true

require "bababaroomba"
require "bababaroomba/models/item"

module Bababaroomba
  module Models
    # Representation of the cleaning robot that moves about the room cleaning things/removing dirt
    class Dirtbot < Item
      def name
        self.class.name
      end

      def z_order
        2
      end

      def glyph
        "@"
      end
    end
  end
end
