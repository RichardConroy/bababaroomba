# frozen_string_literal: true

require "bababaroomba"
require "bababaroomba/models/dirt"
require "bababaroomba/models/dirtbot"
require "bababaroomba/models/floorplan"
require "pry"

RSpec.describe Bababaroomba::Models::Floorplan do
  describe ".generate_default" do
    subject(:floorplan) { described_class.generate_default(4, 4) }

    it "creates floor tiles" do
      expect(floorplan.tiles.count).to eq 16
    end
  end

  describe "#render" do
    subject(:floorplan) { described_class.generate_default(8, 3) }

    it "draws the map on the console" do
      expected_grid = <<~GRID
        ........
        ........
        ........
      GRID
      expect { floorplan.render }.to output(expected_grid).to_stdout
    end

    context "with dirt at 0,0" do
      before do
        floorplan.find!(0, 0).add_item(Bababaroomba::Models::Dirt.new)
      end

      it "draws the map with the dirt" do
        expected_grid = <<~GRID
          ........
          ........
          ~.......
        GRID
        expect { floorplan.render }.to output(expected_grid).to_stdout
      end
    end

    context "with dirt at 1,0" do
      before do
        floorplan.find!(1, 0).add_item(Bababaroomba::Models::Dirt.new)
      end

      it "draws the map with the dirt" do
        expected_grid = <<~GRID
          ........
          ........
          .~......
        GRID
        expect { floorplan.render }.to output(expected_grid).to_stdout
      end
    end

    context "with dirt at 1,1 and 2,2" do
      before do
        floorplan.find!(1, 1).add_item(Bababaroomba::Models::Dirt.new)
        floorplan.find!(2, 2).add_item(Bababaroomba::Models::Dirt.new)
      end

      it "draws the map with the dirt" do
        expected_grid = <<~GRID
          ..~.....
          .~......
          ........
        GRID
        expect { floorplan.render }.to output(expected_grid).to_stdout
      end
    end

    context "with dirt at 1,1 and 2,2 and dirtbot at 2,2" do
      before do
        floorplan.find!(1, 1).add_item(Bababaroomba::Models::Dirt.new)
        floorplan.find!(2, 2).add_item(Bababaroomba::Models::Dirt.new)
        floorplan.find!(2, 2).add_item(Bababaroomba::Models::Dirtbot.new)
      end

      it "draws the map with the dirt" do
        expected_grid = <<~GRID
          ..@.....
          .~......
          ........
        GRID
        expect { floorplan.render }.to output(expected_grid).to_stdout
      end
    end
  end
end
