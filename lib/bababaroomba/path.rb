# frozen_string_literal: true

require "bababaroomba"
require "bababaroomba/models/tile"
require "bababaroomba/models/null_tile"

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
      guard!(tile)

      step_sequence << tile
    end

    def double_back
      # create a shallow clone of the current path and swap origin/current
    end

    def length
      step_sequence.length
    end

    def breadcrumbs
      step_sequence.each_cons(2).map do |pair|
        breadcrumb(calculate_differences(pair))
      end.join("")
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

    def calculate_differences(coordinate_pair)
      {
        x_diff: coordinate_pair.last.coords.x - coordinate_pair.first.coords.x,
        y_diff: coordinate_pair.last.coords.y - coordinate_pair.first.coords.y
      }
    end

    def breadcrumb(x_diff:, y_diff:)
      case [x_diff, y_diff]
      when [1, 0]
        "E"
      when [-1, 0]
        "W"
      when [0, 1]
        "N"
      when [0, -1]
        "S"
      end
    end

    def guard!(tile)
      guard_type! tile
      guard_duplicate! tile
      guard_present_in_floorplan! tile
      guard_passable! tile
      guard_adjacent! tile
    end

    def guard_adjacent!(tile)
      raise ::Bababaroomba::Error, "tile must be adjacent to path.current tile" unless adjacent?(tile)
    end

    def guard_passable!(tile)
      raise ::Bababaroomba::Error, "tile must be passable" unless tile.passable?
    end

    def guard_present_in_floorplan!(tile)
      raise ::Bababaroomba::Error, "tile must be in floorplan" unless floorplan.find(tile.coords.x, tile.coords.y)
    end

    def guard_duplicate!(tile)
      raise ::Bababaroomba::Error, "tile already in path" if step_sequence.include? tile
    end

    def guard_type!(tile)
      raise ::Bababaroomba::Error, "Tile required. #{tile.class} received" unless tile.is_a? Bababaroomba::Models::Tile
    end

    def adjacent?(tile)
      ((current.coords.x + current.coords.y) - (tile.coords.x + tile.coords.y)).abs == 1
    end
  end
end
