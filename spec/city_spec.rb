require 'spec_helper'

describe City do

  before do
    @city = City.new({ id: nil, name: "New_Orleans"})
  end

  describe '#id' do
    it 'returns city id initially set to 0' do
      expect(@city.id).to eq 0
    end
  end

  describe '#name' do
    it "returns the city's name" do
      expect(@city.name).to eq "New_Orleans"
    end
  end

  describe ".all" do
    it 'returns an empty array at first' do
      expect(City.all).to eq []
    end
  end

end
