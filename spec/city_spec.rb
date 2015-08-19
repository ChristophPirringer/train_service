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

end
