# frozen_string_literal: true

require_relative "bababaroomba/version"

require "bababaroomba/models/dirt"
require "bababaroomba/models/dirtbot"
require "bababaroomba/models/floorplan"
require "bababaroomba/path"
require "bababaroomba/services/neighbours"
require "bababaroomba/seek/lazy_maze"
require "pry"

module Bababaroomba
  class Error < StandardError; end

  # Main CLI entrypoint and integration
  class Application
    attr_accessor :floorplan, :dirtbot, :origin

    def initialize
      @floorplan = Models::Floorplan.generate_default(floor_plan_width, floor_plan_height)
      @dirtbot = Models::Dirtbot.new
      @origin = floorplan.find!(0, 0)
      @origin.add_item @dirtbot
      randomly_seed_dirt
    end

    def seek_and_destroy
      while floorplan.tiles.values.any?(&:dirty?)
        start_search
        path = seeking_dirt
        move_dirtbot_to_dirt(path)
        display_floorplan
        clean_dirt
        retrace_steps(path)
        display_floorplan
      end
    end

    def start_search
      floorplan.render
      puts ""
      puts "Looking for dirt .... "
    end

    def seeking_dirt
      path = Path.new origin: @origin, floorplan: @floorplan
      Seek::LazyMaze.call(floorplan: floorplan, path: path)
      puts ".... dirt found!"
      puts path.breadcrumbs
      puts ""
      path
    end

    def move_dirtbot_to_dirt(path)
      puts "Moving dirt bot along path"
      move_dirtbot(path)
    end

    def retrace_steps(path)
      puts "Retracing steps back to origin"
      return_path = path.double_back
      move_dirtbot(return_path)
      puts return_path.breadcrumbs
      puts ""
    end

    def move_dirtbot(path)
      @dirtbot.location.remove_item @dirtbot
      path.current.add_item @dirtbot
    end

    def display_floorplan
      puts ""
      floorplan.render
      puts ""
    end

    def clean_dirt
      puts "Cleaning dirt"
      puts ""
      @dirtbot.clean
    end

    def self.run
      bababaroomba = Application.new
      bababaroomba.seek_and_destroy
    end

    private

    def randomly_seed_dirt
      @floorplan.tiles.values.select(&:passable?).sample(initial_dirt).each { |tile| tile.add_item(Models::Dirt.new) }
    end

    def floor_plan_width
      ARGV.fetch(0, 8).to_i
    end

    def floor_plan_height
      ARGV.fetch(1, 6).to_i
    end

    def initial_dirt
      ARGV.fetch(2, 3).to_i
    end
  end
end
