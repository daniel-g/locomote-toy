module Locomote
  class Toy
    NORTH = :north
    EAST = :east
    SOUTH = :south
    WEST = :west

    LEFT = :left
    RIGHT = :right

    DIRECTIONS = [NORTH, EAST, SOUTH, WEST]

    MAX_X = 4
    MAX_Y = 4

    attr_accessor :position, :direction

    def place(new_x, new_y, new_direction)
      batch do
        self.position = {x: new_x, y: new_y}
        self.direction = new_direction
      end
    end

    def move
      batch do
        case direction
        when NORTH
          self.y = position[:y] + 1
        when EAST
          self.x = position[:x] + 1
        when SOUTH
          self.y = position[:y] - 1
        when WEST
          self.x = position[:x] - 1
        end
      end
    end

    def turn side
      direction_index = DIRECTIONS.index(direction)
      batch do
        case side
        when LEFT
          direction_index = 4 if direction_index == 0
          self.direction = DIRECTIONS[direction_index - 1]
        when RIGHT
          direction_index = -1 if direction_index == 3
          self.direction = DIRECTIONS[direction_index + 1]
        end
      end
    end

    def x
      position[:x]
    end

    def y
      position[:y]
    end

    def report
      "#{position[:x]},#{position[:y]},#{direction.upcase}"
    end

    private

    attr_accessor :last_position, :last_direction

    def batch
      save_last_state
      yield
      rollback if out_of_range?
    end

    def rollback
      @position = last_position
      @direction = last_direction
    end

    def save_last_state
      self.last_position = position
      self.last_direction = direction
    end

    def x= value
      self.position = {x: value, y: position[:y]}
    end

    def y= value
      self.position = {x: position[:x], y: value}
    end

    def out_of_range?
      position[:x] > MAX_X || position[:y] > MAX_Y || position[:x] < 0 || position[:y] < 0
    end
  end
end
