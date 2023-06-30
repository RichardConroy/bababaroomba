# frozen_string_literal: true

module Bababaroomba
  # A sequence of tiles through the floorplan
  class Path
    attr_accessor :origin

    def initialize(origin:, floorplan:)
      @origin = origin
      @current = origin
      @step_sequence = [origin]
      @floorplan = floorplan
    end

    def add_step(tile)
      # guards:
      # tile must be a Tile
      # tile must be connected to :current
      # tile must be passable
      # tile cannot already be in the current path
      # tile must be in floorplan
      step_sequence << tile
    end

    def double_back
      # create a shallow clone of the current path and swap origin/current
    end

    def length
      step_sequence.length
    end

    def breadcrumbs
      # print out the steps ie. NEWSEE
    end

    def fork
      # create a shallow clone of the current path
    end

    def current
      step_sequence.last
    end

    def locations
      step_sequence.dup
    end

    private

    attr_accessor :floorplan, :step_sequence
  end
end
