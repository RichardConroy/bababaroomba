module Bababaroomba
  class Point
    attr_reader :x, :y

    def initialize(x,y)
      @x,@y = x,y
    end

    def eql?(other)
      self.class == other.class &&
      @x == other.x && @y == other.y
    end

    def hash
      [self.class, @x, @y].hash
    end
  end
end
