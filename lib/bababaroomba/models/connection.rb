# frozen_string_literal: true

require "bababaroomba"
require "bababaroomba/models/tile"

module Bababaroomba
  module Models
    # Represents the connection between 2 tiles along a N-S/E-W axis
    class Connection
      AXES = %i[ns ew].freeze
      attr_reader :first_tile, :second_tile, :axis

      def self.create(ne_tile, sw_tile, axis:)
        # validations ne_tile != sw_tile
        connection Connection.new
        connection.first_tile = ne_tile
        connection.second_tile = sw_tile
        connection.axis = axis
        connection.link_tiles
      end

      def link_tiles; end
    end
  end
end
