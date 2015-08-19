class City
  attr_reader :id, :name

  def initialize(attributes)
    @name = attributes[:name]
    @id = attributes[:id].to_i
  end

  def self.all
    returned_citiess = DB.exec("SELECT * FROM cities")
    cities = []
    returned_citiess.each do |city|
      name = city['name']
      id = city['id']
      cities.push(City.new({name: name, id: id}))
    end
    cities
  end

end
