require 'spec_helper'
require_relative '../lib/locomote'

describe Locomote::Instructions do
  let(:instructions) { Locomote::Instructions.new }

  it 'loads instructions from file' do
    instructions.load(File.open('spec/fixtures/instructions.txt'))
    expect(instructions.instructions.count).to eq 3
  end

  it 'loads instructions from string' do
    instructions.load('
      PLACE 1,2,EAST
      MOVE
      MOVE
      LEFT
      MOVE
      REPORT
    ')
    expect(instructions.instructions.count).to eq 6
    expect(instructions.instructions[0]).to be_kind_of Locomote::Instructions::Place
    expect(instructions.instructions[1]).to be_kind_of Locomote::Instructions::Move
    expect(instructions.instructions[3]).to be_kind_of Locomote::Instructions::Turn
    expect(instructions.instructions[5]).to be_kind_of Locomote::Instructions::Report
  end

  it 'raises a CommandNotKnown exception if the command is not known' do
    expect{
      instructions.load('
        PLACE 1,2,EAST
        MOVES
        MOVE
        LEFT
        MOVE
        REPORT
      ')
    }.to raise_error(Locomote::Instructions::CommandNotKnown)
  end

  it 'executes instructions from file' do
    instructions.load('
      PLACE 1,2,EAST
      MOVE
      MOVE
      LEFT
      MOVE
      REPORT
    ')
    expect($stdout).to receive(:puts).with('3,3,NORTH')
    instructions.exec
  end
end
