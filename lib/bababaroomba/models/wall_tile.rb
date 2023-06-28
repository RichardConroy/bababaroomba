module WallTile
  class WallTile < Tile
    def passable?
      false
    end

    def glyph
      '#'
    end
  end
end
