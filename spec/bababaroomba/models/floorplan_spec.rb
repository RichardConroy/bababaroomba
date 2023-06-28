require 'bababaroomba'
require 'bababaroomba/models/floorplan'
require 'pry'

RSpec.describe Bababaroomba::Models::Floorplan do 
  describe '.generate_default' do

    subject(:floorplan) { described_class.generate_default(4,4)}
    it 'creates a floorplan' do

    end

    it 'connects all tiles' do

    end

    it 'creates floor tiles' do
      expect(floorplan.tiles.count).to eq 16
    end
  end

  describe '#render' do
    subject(:floorplan) { described_class.generate_default(8,3)}

    it 'draws the map on the console' do
      expected_grid = <<~GRID
        ........
        ........
        ........
      GRID
      expect { floorplan.render }.to output(expected_grid).to_stdout
    end
  end
end
