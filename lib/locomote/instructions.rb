module Locomote
  class Instructions
    attr_accessor :instructions

    def load(file_or_string)
      instructions_string = file_or_string
      instructions_string = file_or_string.read if file_or_string.kind_of?(File)
      self.instructions = instructions_string.split(/\n/).reduce([]) do |res, item|
        item=item.strip
        res << translate_instruction(item) unless item == ''
        res
      end
    end

    def exec
      toy = Locomote::Toy.new
      instructions.each do |instruction|
        instruction.exec(toy)
      end
    end

    private

    def translate_instruction(string)
      instruction, parameters = string.split(/\s+/)
      case instruction
      when 'PLACE'
        x, y, direction = parameters.split(',')
        x, y = x.to_i, y.to_i
        direction = Locomote::Toy.const_get(direction)
        Locomote::Instructions::Place.new(x, y, direction)
      when 'LEFT', 'RIGHT'
        Locomote::Instructions::Turn.new(Locomote::Toy.const_get(instruction))
      when 'MOVE'
        Locomote::Instructions::Move.new
      when 'REPORT'
        Locomote::Instructions::Report.new
      end
    end

    class Place
      attr_accessor :x, :y, :direction

      def initialize x, y, direction
        @x, @y, @direction = x, y, direction
      end

      def exec(toy)
        toy.place(x, y, direction)
      end
    end

    class Turn
      attr_accessor :side

      def initialize side
        @side = side
      end

      def exec(toy)
        toy.turn(side)
      end
    end

    class Move
      def exec(toy)
        toy.move
      end
    end

    class Report
      def exec(toy)
        report = toy.report
        puts report
      end
    end
  end
end
