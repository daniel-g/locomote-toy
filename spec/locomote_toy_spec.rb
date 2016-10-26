require 'spec_helper'
require_relative '../lib/locomote'

describe Locomote::Toy do
  let(:locomote_toy) { Locomote::Toy.new }

  it 'places the locomote to a position' do
    locomote_toy.place(2, 3, Locomote::Toy::NORTH)
    expect(locomote_toy.x).to eq 2
    expect(locomote_toy.y).to eq 3
    expect(locomote_toy.direction).to eq Locomote::Toy::NORTH
  end

  it 'moves north' do
    locomote_toy.place(2, 2, Locomote::Toy::NORTH)
    locomote_toy.move
    expect(locomote_toy.x).to eq 2
    expect(locomote_toy.y).to eq 3
    expect(locomote_toy.direction).to eq Locomote::Toy::NORTH
  end

  it 'moves east' do
    locomote_toy.place(2, 2, Locomote::Toy::EAST)
    locomote_toy.move
    expect(locomote_toy.x).to eq 3
    expect(locomote_toy.y).to eq 2
    expect(locomote_toy.direction).to eq Locomote::Toy::EAST
  end

  it 'moves south' do
    locomote_toy.place(2, 2, Locomote::Toy::SOUTH)
    locomote_toy.move
    expect(locomote_toy.x).to eq 2
    expect(locomote_toy.y).to eq 1
    expect(locomote_toy.direction).to eq Locomote::Toy::SOUTH
  end

  it 'moves west' do
    locomote_toy.place(2, 2, Locomote::Toy::WEST)
    locomote_toy.move
    expect(locomote_toy.x).to eq 1
    expect(locomote_toy.y).to eq 2
    expect(locomote_toy.direction).to eq Locomote::Toy::WEST
  end

  it 'does not place the locomote to a position out of range' do
    locomote_toy.place(2, 2, Locomote::Toy::NORTH)
    x, y = [[Locomote::Toy::MAX_X + 1, 0], [0, Locomote::Toy::MAX_Y + 1], [-1, 0], [0, -1]].sample
    locomote_toy.place(x, y, Locomote::Toy::SOUTH)
    expect(locomote_toy.x).to eq 2
    expect(locomote_toy.y).to eq 2
    expect(locomote_toy.direction).to eq Locomote::Toy::NORTH
  end

  it 'does not move if it is out of range on the north' do
    locomote_toy.place(0, Locomote::Toy::MAX_Y, Locomote::Toy::NORTH)
    locomote_toy.move
    expect(locomote_toy.x).to eq 0
    expect(locomote_toy.y).to eq 4
    expect(locomote_toy.direction).to eq Locomote::Toy::NORTH
  end

  it 'does not move if it is out of range on the east' do
    locomote_toy.place(Locomote::Toy::MAX_X, 0, Locomote::Toy::EAST)
    locomote_toy.move
    expect(locomote_toy.x).to eq Locomote::Toy::MAX_X
    expect(locomote_toy.y).to eq 0
    expect(locomote_toy.direction).to eq Locomote::Toy::EAST
  end

  it 'does not move if it is out of range on the south' do
    locomote_toy.place(0, 0, Locomote::Toy::SOUTH)
    locomote_toy.move
    expect(locomote_toy.x).to eq 0
    expect(locomote_toy.y).to eq 0
    expect(locomote_toy.direction).to eq Locomote::Toy::SOUTH
  end

  it 'does not move if it is out of range on the west' do
    locomote_toy.place(0, 0, Locomote::Toy::WEST)
    locomote_toy.move
    expect(locomote_toy.x).to eq 0
    expect(locomote_toy.y).to eq 0
    expect(locomote_toy.direction).to eq Locomote::Toy::WEST
  end

  it 'reports the current position' do
    locomote_toy.place(2, 2, Locomote::Toy::WEST)
    expect(locomote_toy.report).to eq('2,2,WEST')
  end
end
