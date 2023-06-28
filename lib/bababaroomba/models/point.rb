# frozen_string_literal: true

module Bababaroomba
  module Models
    # Representation of an x-y coordinate on a geometric plane
    class Point
      attr_reader :x, :y

      def initialize(x_coord, y_coord)
        @x = x_coord
        @y = y_coord
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
end
