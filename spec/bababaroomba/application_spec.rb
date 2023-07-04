# frozen_string_literal: true

require "bababaroomba"
require "bababaroomba/models/dirt"
require "bababaroomba/services/floorplan_generator"

RSpec.describe Bababaroomba::Application do
  subject(:application) { described_class.new floorplan: floorplan }

  let(:floorplan) { Bababaroomba::Services::FloorplanGenerator.call(width: 5, height: 4, dirt: 0) }

  before { floorplan.find!(1, 2).add_item(Bababaroomba::Models::Dirt.new) }

  describe "#seek_and_destroy" do
    it "renders the initial grid" do
      expected = <<~INITIAL_GRID
        .....
        .~...
        .....
        @....
      INITIAL_GRID
      expect { application.seek_and_destroy }.to output(Regexp.new(expected)).to_stdout
    end

    it "renders the path to the dirt" do
      expect { application.seek_and_destroy }.to output(/NNNES/).to_stdout
    end

    it "renders the grid after the bot has moved" do
      expected = <<~GRID_AFTER_MOVE
        .....
        .@...
        .....
        .....
      GRID_AFTER_MOVE
      expect { application.seek_and_destroy }.to output(Regexp.new(expected)).to_stdout
    end

    it "renders the return path" do
      expect { application.seek_and_destroy }.to output(/NWSSS/).to_stdout
    end

    it "renders the grid after the bot has moved to origin" do
      expected = <<~GRID_RETURNED
        .....
        .....
        .....
        @....
      GRID_RETURNED
      expect { application.seek_and_destroy }.to output(Regexp.new(expected)).to_stdout
    end
  end
end
