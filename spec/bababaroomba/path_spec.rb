# frozen_string_literal: true

require "bababaroomba/path"
require "bababaroomba/models/floorplan"
require "bababaroomba/models/tile"

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
  end
end
