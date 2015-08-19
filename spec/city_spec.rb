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

  describe "#save" do
    it 'saves the city' do
      @city.save
      expect(City.all).to eq [@city]
    end
  end

  describe "#==" do
    it 'returns true when all attributes are the same' do
      city2 = City.new({ id: nil, name: "New_Orleans"})
      expect(@city).to eq city2
    end
  end

  describe ".find" do
    it 'returns a city when that city id is passed in' do
      @city.save
      expect(City.find(@city.id)).to eq @city
    end
  end
  describe '#update' do
    it 'it returns city with new name' do
      @city.save
      @city.update({name: 'Blain'})
      expect(@city.name).to eq "Blain"
    end
  end

  describe '#destroy' do
    it 'it removes city from the database' do
      @city.save
      @city.destroy
      @cities = City.all
      expect(@cities.include?(@city)).to eq false
    end
  end

end
