require('./lib/train')

class City
  attr_reader :id, :name

  def initialize(attributes)
    @name = attributes[:name]
    @id = attributes[:id].to_i
  end

  def update(attributes)
    @name = attributes.fetch(:name, @name)

    DB.exec("UPDATE cities SET name = '#{@name}' WHERE id = #{self.id};")

    attributes.fetch(:train_ids, []).each() do |train_id|
      DB.exec("INSERT INTO trains_cities (city_id, train_id) VALUES (#{self.id}, #{train_id});")
    end
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

  def trains
    city_trains = []
    results = DB.exec("SELECT train_id, arrival_time FROM trains_cities WHERE city_id = #{self.id}")
    results.each do |result|
      train_id = result['train_id'].to_i
      train = DB.exec("SELECT * FROM trains WHERE id = #{train_id}")
      arrival_time = result['arrival_time']
      name = train.first.fetch('name')
      city_trains.push([Train.new({ name: name, id: train_id}), arrival_time])
    end
    city_trains
  end



end
