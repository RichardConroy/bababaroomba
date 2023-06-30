# frozen_string_literal: true

module Bababaroomba
  module Models
    # Represents the connection between 2 tiles along a N-S/E-W axis
    class Connection
      AXES = %i[ns ew i_dont_care].freeze
      attr_accessor :first_tile, :second_tile, :axis

      # def self.create(ne_tile, sw_tile, axis: :i_dont_care)
      #   # validations ne_tile != sw_tile
      #   connection = Connection.new
      #   connection.first_tile = ne_tile
      #   connection.second_tile = sw_tile
      #   connection.axis = axis
      #   connection.link_tiles
      # end

      # def link_tiles
      #   first_tile.connect(self)
      #   second_tile.connect(self)
      # end
    end
  end
end
