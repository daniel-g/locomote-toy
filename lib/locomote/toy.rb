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
      batch{ send("move_#{direction}") }
    end

    def turn side
      batch{ send("turn_#{side}") }
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

    def move_north
      self.y = position[:y] + 1
    end

    def move_east
      self.x = position[:x] + 1
    end

    def move_south
      self.y = position[:y] - 1
    end

    def move_west
      self.x = position[:x] - 1
    end

    def direction_index
      DIRECTIONS.index(direction)
    end

    def turn_left
      index = direction_index
      index = 4 if direction_index == 0
      self.direction = DIRECTIONS[index - 1]
    end

    def turn_right
      index = direction_index
      index = -1 if direction_index == 3
      self.direction = DIRECTIONS[index + 1]
    end

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
