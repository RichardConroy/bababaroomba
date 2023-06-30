# frozen_string_literal: true

require "bababaroomba/models/connection"
require "bababaroomba/models/dirt"
require "bababaroomba/models/dirtbot"
require "bababaroomba/models/floor_tile"
require "bababaroomba/models/null_tile"
require "bababaroomba/models/point"
require "pry"

RSpec.describe Bababaroomba::Models::FloorTile do
  subject(:floor_tile) { described_class.new point: point }

  let(:x_coord) { 2 }
  let(:y_coord) { 3 }
  let(:point) { Bababaroomba::Models::Point.new x_coord, y_coord }
  let(:dirt) { Bababaroomba::Models::Dirt.new }

  describe "#add_item" do
    it "masks the floortile glyph" do
      expect { floor_tile.add_item(dirt) }.to change(floor_tile, :glyph).from(".").to(dirt.glyph)
    end

    it "assigns item location to itself" do
      expect { floor_tile.add_item(dirt) }.to change(dirt, :location).to(floor_tile)
    end

    context "when not an Item" do
      it "raises" do
        expect { floor_tile.add_item "fooobaar" }.to raise_error(ArgumentError)
      end
    end

    context "when item already at another tile" do
      # (a) remove from other tile and add here, or raise, or introduce #move_item
      xit "consider the correct behaviour here"
    end

    context "with multiple objects" do
      let(:dirtbot) { Bababaroomba::Models::Dirtbot.new }

      it "masks the floortile glyph with the item of highest Z-order" do
        floor_tile.add_item(dirtbot)
        floor_tile.add_item(dirt)

        expect(floor_tile.glyph).to eq dirtbot.glyph
      end
    end
  end

  describe "#remove_item" do
    context "when item not at this tile" do
      it "raises" do
        expect { floor_tile.remove_item(dirt) }.to raise_error(ArgumentError) # TODO: make a custom error
      end
    end

    context "when item at another tile" do
      let(:other_point) { Bababaroomba::Models::Point.new 9, 9 }
      let(:other_floor_tile) { described_class.new other_point: point }

      before { other_floor_tile.add_item dirt }

      xit "consider if this is necessary"
    end

    context "when not an Item" do
      it "raises" do
        expect { floor_tile.remove_item "fooobaar" }.to raise_error(ArgumentError)
      end
    end
  end

  describe "#dirty?" do
    let(:dirtbot) { Bababaroomba::Models::Dirtbot.new }

    it { is_expected.not_to be_dirty }

    context "with dirt" do
      before { floor_tile.add_item(dirt) }

      it { is_expected.to be_dirty }
    end

    context "with dirt and dirtbot" do
      before do
        floor_tile.add_item(dirt)
        floor_tile.add_item(dirtbot)
      end

      it { is_expected.to be_dirty }
    end

    context "when dirt removed" do
      before do
        floor_tile.add_item(dirt)
        floor_tile.add_item(dirtbot)
      end

      it { expect { floor_tile.remove_item(dirt) }.to change(floor_tile, :dirty?).from(true).to(false) }
    end
  end

  # TODO: move #neighbours specs to superclass or another service

  describe "#neighbours" do # rubocop:disable RSpec/MultipleMemoizedHelpers
    let(:north_neighbour) { described_class.new point: Bababaroomba::Models::Point.new(x_coord, y_coord + 1) }
    let(:south_neighbour) { described_class.new point: Bababaroomba::Models::Point.new(x_coord, y_coord - 1) }
    let(:west_neighbour) { Bababaroomba::Models::NullTile.new point: Bababaroomba::Models::Point.new(-1001, -1001) }
    let(:east_neighbour) { described_class.new point: Bababaroomba::Models::Point.new(x_coord + 1, y_coord) }

    # before do
    #   Bababaroomba::Models::Connection.create north_neighbour, floor_tile
    #   Bababaroomba::Models::Connection.create floor_tile, south_neighbour
    #   Bababaroomba::Models::Connection.create east_neighbour, floor_tile
    #   Bababaroomba::Models::Connection.create floor_tile, west_neighbour
    # end

    it "includes passable neighboring tiles" do
      expect(floor_tile.neighbours).to include north_neighbour, south_neighbour, east_neighbour
    end

    it "omits impassable tiles" do
      expect(floor_tile.neighbours).not_to include west_neighbour
    end
  end
end
