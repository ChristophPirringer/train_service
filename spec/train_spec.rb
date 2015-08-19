require 'spec_helper'

describe Train do

  before do
    @train = Train.new({ id: nil, name: "City_Of_New_Orleans"})
  end

  describe '#id' do
    it 'returns trains id initially set to 0' do
      expect(@train.id).to eq 0
    end
  end

  describe '#name' do
    it 'returns trains name' do
      expect(@train.name).to eq "City_Of_New_Orleans"
    end
  end

  describe '.all' do
    it 'returns an empty array at first' do
      expect(Train.all).to eq []
    end
  end


end
