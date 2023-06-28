# frozen_string_literal: true

require "bababaroomba"

module Bababaroomba
  module Models
    # Base abstract class for an object that can exist on the floor
    class Item
      attr_accessor :location

      def name
        "Base"
      end

      def z_order
        -1
      end

      def glyph
        "O"
      end
    end
  end
end
