require_relative 'instructions/place'
require_relative 'instructions/move'
require_relative 'instructions/turn'
require_relative 'instructions/report'

module Locomote
  class Instructions
    attr_accessor :instructions, :toy

    def initialize
      @toy = Locomote::Toy.new
    end

    def load(file_or_string)
      instructions_string = file_or_string
      instructions_string = file_or_string.read if file_or_string.kind_of?(File)
      self.instructions = instructions_string.split(/\n/).reduce([]) do |res, item|
        item.strip!
        next res if item == ''
        res << translate_instruction(item)
      end
    end

    def exec
      instructions.each do |instruction|
        instruction.exec(toy)
      end
    end

    private

    def translate_instruction(string)
      instruction, parameters = string.split(/\s+/)
      send("create_#{instruction.downcase}", parameters)
    rescue NoMethodError
      raise Locomote::Instructions::CommandNotKnown.new("Received command not known: #{instruction}")
    end

    def create_place parameters
      x, y, direction = parameters.split(',')
      x, y = x.to_i, y.to_i
      direction = Locomote::Toy.const_get(direction)
      Place.new(x, y, direction)
    end

    def create_left parameters
      Turn.new(Locomote::Toy::LEFT)
    end

    def create_right parameters
      Turn.new(Locomote::Toy::RIGHT)
    end

    def create_move parameters
      Move.new
    end

    def create_report parameters
      Report.new
    end

    class CommandNotKnown < StandardError
    end
  end
end
