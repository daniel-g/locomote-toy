require 'spec_helper'
require_relative '../lib/locomote_toy'

describe LocomoteToy do
  let(:locomote_toy) { LocomoteToy.new }

  it 'places the locomote to a position' do
    locomote_toy.place(2, 3, LocomoteToy::NORTH)
    expect(locomote_toy.x).to eq 2
    expect(locomote_toy.y).to eq 3
    expect(locomote_toy.direction).to eq LocomoteToy::NORTH
  end

  it 'moves north' do
    locomote_toy.place(2, 2, LocomoteToy::NORTH)
    locomote_toy.move
    expect(locomote_toy.x).to eq 2
    expect(locomote_toy.y).to eq 3
    expect(locomote_toy.direction).to eq LocomoteToy::NORTH
  end

  it 'moves east' do
    locomote_toy.place(2, 2, LocomoteToy::EAST)
    locomote_toy.move
    expect(locomote_toy.x).to eq 3
    expect(locomote_toy.y).to eq 2
    expect(locomote_toy.direction).to eq LocomoteToy::EAST
  end

  it 'moves south' do
    locomote_toy.place(2, 2, LocomoteToy::SOUTH)
    locomote_toy.move
    expect(locomote_toy.x).to eq 2
    expect(locomote_toy.y).to eq 1
    expect(locomote_toy.direction).to eq LocomoteToy::SOUTH
  end

  it 'moves west' do
    locomote_toy.place(2, 2, LocomoteToy::WEST)
    locomote_toy.move
    expect(locomote_toy.x).to eq 1
    expect(locomote_toy.y).to eq 2
    expect(locomote_toy.direction).to eq LocomoteToy::WEST
  end

  it 'does not place the locomote to a position out of range' do
    locomote_toy.place(2, 2, LocomoteToy::NORTH)
    x, y = [[LocomoteToy::MAX_X + 1, 0], [0, LocomoteToy::MAX_Y + 1], [-1, 0], [0, -1]].sample
    locomote_toy.place(x, y, LocomoteToy::SOUTH)
    expect(locomote_toy.x).to eq 2
    expect(locomote_toy.y).to eq 2
    expect(locomote_toy.direction).to eq LocomoteToy::NORTH
  end

  it 'does not move if it is out of range on the north' do
    locomote_toy.place(0, LocomoteToy::MAX_Y, LocomoteToy::NORTH)
    locomote_toy.move
    expect(locomote_toy.x).to eq 0
    expect(locomote_toy.y).to eq 4
    expect(locomote_toy.direction).to eq LocomoteToy::NORTH
  end

  it 'does not move if it is out of range on the east' do
    locomote_toy.place(LocomoteToy::MAX_X, 0, LocomoteToy::EAST)
    locomote_toy.move
    expect(locomote_toy.x).to eq LocomoteToy::MAX_X
    expect(locomote_toy.y).to eq 0
    expect(locomote_toy.direction).to eq LocomoteToy::EAST
  end

  it 'does not move if it is out of range on the south' do
    locomote_toy.place(0, 0, LocomoteToy::SOUTH)
    locomote_toy.move
    expect(locomote_toy.x).to eq 0
    expect(locomote_toy.y).to eq 0
    expect(locomote_toy.direction).to eq LocomoteToy::SOUTH
  end

  it 'does not move if it is out of range on the west' do
    locomote_toy.place(0, 0, LocomoteToy::WEST)
    locomote_toy.move
    expect(locomote_toy.x).to eq 0
    expect(locomote_toy.y).to eq 0
    expect(locomote_toy.direction).to eq LocomoteToy::WEST
  end

  it 'reports the current position' do
    locomote_toy.place(2, 2, LocomoteToy::WEST)
    expect(locomote_toy.report).to eq('2,2,WEST')
  end
end
