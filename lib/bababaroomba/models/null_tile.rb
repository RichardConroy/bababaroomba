module Bababaroomba
  class NullTile < Tile
    # Representation of null space on the map

    def passable?
      false
    end

    def glyph
      ' '
    end
  end
end
