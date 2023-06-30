# frozen_string_literal: true

require "bababaroomba/models/item"

module Bababaroomba
  module Models
    # Floor object that can be cleaned by the Dirtbot
    class Dirt < Item
      def name
        "Dirt"
      end

      def z_order
        1
      end

      def glyph
        "~"
      end
    end
  end
end
