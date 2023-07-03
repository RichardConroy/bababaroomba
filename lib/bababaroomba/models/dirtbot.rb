# frozen_string_literal: true

require "bababaroomba/models/item"
require "bababaroomba/models/dirt"

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

      def clean
        location.contents.select { |item| item.instance_of?(Dirt) }.each { |dirt| location.remove_item(dirt) }
      end
    end
  end
end
