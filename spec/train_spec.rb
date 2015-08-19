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

  describe '#save' do
    it 'saves a train and returns an array with it' do
      @train.save
      expect(Train.all).to eq [@train]
    end
  end

  describe "#==" do
    it 'returns true when trains have the same attributes' do
      train2 = Train.new({ id: nil, name: "City_Of_New_Orleans"})
      expect(@train).to eq train2
    end
  end

  describe '.find' do
    it 'returns a train based on passed in id' do
      @train.save
      expect(Train.find(@train.id)).to eq @train
    end
  end

  describe '#update' do
    it 'it returns train with new name' do
      @train.save
      @train.update({name: 'Blain'})
      expect(@train.name).to eq "Blain"
    end
  end


end
