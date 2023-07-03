# frozen_string_literal: true

require "bababaroomba/services/neighbours"
require "bababaroomba/models/floorplan"
require "bababaroomba/models/point"
require "bababaroomba/models/tile"

RSpec.describe Bababaroomba::Services::Neighbours, type: :service do
  subject(:neighbours) { described_class.call(floorplan: floorplan, tile: tile) }

  let(:floorplan) { Bababaroomba::Services::FloorplanGenerator.call(width: 8, height: 5) }
  let(:x_coord) { 1 }
  let(:y_coord) { 1 }
  let(:tile) { floorplan.find! x_coord, y_coord }

  it "returns a collection of 4 tiles from the 4 compass directions", aggregate_failures: true do
    expect(neighbours).to include(
      floorplan.find!(0, 1),
      floorplan.find!(2, 1),
      floorplan.find!(1, 0),
      floorplan.find!(1, 2)
    )
    expect(neighbours.size).to eq 4
  end

  context "when at an edge", aggregate_failures: true do
    let(:x_coord) { 0 }
    let(:y_coord) { 1 }

    it "returns a collection of 3 adjacent tiles", aggregate_failures: true do
      expect(neighbours).to include(
        floorplan.find!(1, 1),
        floorplan.find!(0, 0),
        floorplan.find!(0, 2)
      )
      expect(neighbours.size).to eq 3
    end
  end

  context "when at an corner", aggregate_failures: true do
    let(:x_coord) { 7 }
    let(:y_coord) { 4 }

    it "returns 2 tiles" do
      expect(neighbours).to include(
        floorplan.find!(6, 4),
        floorplan.find!(7, 3)
      )
      expect(neighbours.size).to eq 2
    end
  end

  context "when outside the room" do
    let(:x_coord) { 10 }
    let(:y_coord) { 10 }

    xit "raises" do
      expect { neighbours }.to raise_error Bababaroomba::Error
    end
  end
end
