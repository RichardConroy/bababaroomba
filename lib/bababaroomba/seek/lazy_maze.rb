# frozen_string_literal: true

require "bababaroomba/models/point"
module Bababaroomba
  module Seek
    # A search pattern that recursively takes the first option available to it.
    class LazyMaze
      class << self
        def call(**args)
          new(**args).call
        end
      end

      def initialize(floorplan:, path:)
        @floorplan = floorplan
        @path = path
      end

      def call
        recursive_call(path)
      end

      private

      def recursive_call(extended_path)
        location = extended_path.current
        return path if location.dirty?

        unvisited_neighbours = neighbours(location) - extended_path.locations
        raise Error, "Painted into corner!" if unvisited_neighbours.empty?

        extended_path.add_step(unvisited_neighbours.first)
        recursive_call(extended_path)
      end

      attr_accessor :floorplan, :path

      def neighbours(location)
        Bababaroomba::Services::Neighbours.call(floorplan: @floorplan,
                                                tile: location).select(&:passable?)
      end
    end
  end
end
