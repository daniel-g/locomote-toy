class Turn
  attr_accessor :side

  def initialize side
    @side = side
  end

  def exec(toy)
    toy.turn(side)
  end
end
