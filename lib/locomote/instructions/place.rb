module Locomote
  class Instructions
    class Place
      attr_accessor :x, :y, :direction

      def initialize x, y, direction
        @x, @y, @direction = x, y, direction
      end

      def exec(toy)
        toy.place(x, y, direction)
      end
    end
  end
end
