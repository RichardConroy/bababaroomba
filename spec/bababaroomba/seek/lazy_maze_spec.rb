# frozen_string_literal: true

require "bababaroomba/models/floorplan"
require "bababaroomba/path"
require "bababaroomba/models/dirt"
require "bababaroomba/models/tile"

RSpec.describe Bababaroomba::Seek::LazyMaze, type: :service do
  subject(:lazy_maze) { described_class.call(floorplan: floorplan, path: path) }

  let(:floorplan) { Bababaroomba::Services::FloorplanGenerator.call(width: 4, height: 4, dirt: 0) }
  let(:x_coord) { 0 }
  let(:y_coord) { 0 }
  let(:tile) { floorplan.find! x_coord, y_coord }
  let(:path) { Bababaroomba::Path.new origin: tile, floorplan: floorplan }
  let(:dirt) { Bababaroomba::Models::Dirt.new }

  before { floorplan.find!(1, 1).add_item(dirt) }

  it "returns a long path traversing NNNESS from origin" do
    expect(lazy_maze.breadcrumbs).to eq "NNNESS"
  end
end
