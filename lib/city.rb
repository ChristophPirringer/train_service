class City
  attr_reader :id, :name

  def initialize(attributes)
    @name = attributes[:name]
    @id = attributes[:id].to_i
  end

  def update(attributes)
    @name = attributes[:name]
    @id = self.id
    DB.exec("UPDATE cities SET name = '#{@name}' WHERE id = #{@id};")
  end

  def destroy
    DB.exec("DELETE FROM cities WHERE id = #{self.id};")
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

  def self.find (city_id)
    found_city = nil
    returned_cities = DB.exec("SELECT * FROM cities WHERE id = #{city_id};")
    returned_cities.each() do |city|
      if city['id'].to_i == city_id
        found_city = City.new({id: city['id'], name: city['name']})
      end
    end
    found_city
  end



end
