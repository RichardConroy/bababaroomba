# frozen_string_literal: true

require "bababaroomba"
require "bababaroomba/path"
require "bababaroomba/models/floorplan"
require "bababaroomba/models/tile"
require "bababaroomba/models/null_tile"
require "bababaroomba/models/point"

RSpec.describe Bababaroomba::Path do
  subject(:path) { described_class.new origin: origin, floorplan: floorplan }

  let(:floorplan) { Bababaroomba::Models::Floorplan.generate_default(8, 5) }
  let(:origin) { floorplan.find! 2, 2 }

  describe "#add_step" do
    context "with adjacent tile" do
      let(:next_tile) { floorplan.find! 2, 3 }

      it "successfully adds the tile" do
        expect { path.add_step(next_tile) }.to change(path, :length).by(1)
      end

      it "updates the current position" do
        expect { path.add_step(next_tile) }.to change(path, :current).to(next_tile)
      end
    end

    context "with non-adjacent tile" do
      let(:next_tile) { floorplan.find! 5, 3 }

      it { expect { path.add_step(next_tile) }.to raise_error Bababaroomba::Error }
    end

    context "with impassible tile" do
      let(:next_tile) { Bababaroomba::Models::NullTile.new point: Bababaroomba::Models::Point.new(2, 2) }

      it { expect { path.add_step(next_tile) }.to raise_error Bababaroomba::Error }
    end

    context "with nil" do
      let(:next_tile) { nil }

      it { expect { path.add_step(next_tile) }.to raise_error Bababaroomba::Error }
    end

    context "when not a tile" do
      let(:next_tile) { {} }

      it { expect { path.add_step(next_tile) }.to raise_error Bababaroomba::Error }
    end

    context "when tile is present in path" do
      let(:next_tile) { floorplan.find! 3, 2 }

      before do
        3.upto(5) { |n| path.add_step(floorplan.find!(n, 2)) }
      end

      it "raises" do
        expect { path.add_step(next_tile) }.to raise_error(Bababaroomba::Error)
      end
    end
  end

  describe "#breadcrumbs" do
    context "when path length == 1" do
      it "has no breadcrumbs" do
        expect(path.breadcrumbs).to eq ""
      end
    end

    context "with multiple steps" do
      before do
        [[3, 2], [3, 3], [3, 4], [2, 4], [1, 4], [1, 3], [1, 2]].each do |coords|
          path.add_step(floorplan.find!(*coords))
        end
      end

      it "spells out the coordinate transitions in NSEW format" do
        expect(path.breadcrumbs).to eq "ENNWWSS"
      end
    end
  end
end
