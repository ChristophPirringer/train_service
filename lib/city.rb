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

  def save
    result = DB.exec("INSERT INTO cities (name) VALUES ('#{self.name}') RETURNING id;")
    @id = result.first.fetch('id').to_i
  end

  def == (another_city)
    self.name == another_city.name &&
    self.id == another_city.id
  end

end
