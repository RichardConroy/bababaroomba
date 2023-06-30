# frozen_string_literal: true

require_relative "bababaroomba/version"

require "bababaroomba/models/dirt"
require "bababaroomba/models/dirtbot"
require "bababaroomba/models/floorplan"
require "bababaroomba/path"
require "bababaroomba/services/neighbours"
require "pry"

module Bababaroomba
  class Error < StandardError; end

  # Main CLI entrypoint and integration
  class Application
    attr_accessor :floorplan, :dirtbot, :origin

    def initialize
      @floorplan = Models::Floorplan.generate_default(8, 5)
      @dirtbot = Models::Dirtbot.new
      @origin = floorplan.find!(0, 0)
      @origin.add_item @dirtbot
      randomly_seed_dirt
    end

    def seek_and_destroy
      floorplan.render
      # Services::Seek::LazyMaze.call # take first (unpassable) connections at every tile

      current_location = dirtbot.location
      path = Path.new origin: @origin, floorplan: @floorplan
      path.add_step(current_location)
      path = seek_dirt(path)
      puts path.breadcrumbs
    end

    def seek_dirt(path)
      location = path.current
      return path if location.dirty?

      unvisited_neighbours = Bababaroomba::Services::Neighbours.call(floorplan: @floorplan,
                                                                     tile: location).map(&:passable?)
      raise Error, "Painted into corner!" if unvisited_neighbours.empty?

      path.add_step(unvisited_neighbours.first)
      seek_dirt(path)
    end

    def self.run
      bababaroomba = Application.new
      bababaroomba.seek_and_destroy

      # draw floorplan
      # loop do
      # while current has no dirt && path.length < flooplan.tiles.count && dirt remains
      # next_path = current_path.exits.passable.unvisited.first
      # current_path.add_step(next_path)
      # has dirt ?
      # clean it / print out path steps / print out map / reverse path / return to origin
      # render map again
      # endloop
      # retry until all dirt gone

      # policy 2:
      # all paths = current_path.sexits.passable.unvisited.map { fork current path and add each exit to the new path }
      # if any path has dirt, discard all paths and travel to it
    end

    private

    def randomly_seed_dirt
      @floorplan.tiles.values.select(&:passable?).sample(1).each { |tile| tile.add_item(Models::Dirt.new) }
    end
  end
end

# Bababaroomba::Application.run
