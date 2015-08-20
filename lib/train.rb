require './lib/city'
require 'pry'

class Train
  attr_reader :id, :name

  def initialize(attributes)
    @name = attributes[:name]
    @id = attributes[:id].to_i
  end

  def self.all
    returned_trains = DB.exec("SELECT * FROM trains")
    trains = []
    returned_trains.each do |train|
      name = train['name']
      id = train['id']
      trains.push(Train.new({name: name, id: id}))
    end
    trains
  end

  def save
    result = DB.exec("INSERT INTO trains (name) VALUES ('#{self.name}') RETURNING id;")
    @id = result.first.fetch('id').to_i
  end

  def == (another_train)
    another_train.id == self.id &&
    another_train.name == self.name
  end

  def self.find(train_id)
    found_train = nil
    returned_trains = DB.exec("SELECT * FROM trains WHERE id = #{train_id};")
    returned_trains.each do |train|
      if train['id'].to_i == train_id
        found_train = Train.new({name: train['name'], id: train['id']})
      end
    end
    found_train
  end

  def update(attributes)

    @name = attributes[:name]
    #binding.pry
    @arrival_time = attributes[:arrival_time]


    DB.exec("UPDATE trains SET name = '#{@name}' WHERE id = #{self.id};")

    attributes.fetch(:city_ids, []).each() do |city_id|
      DB.exec("INSERT INTO trains_cities (city_id, train_id, arrival_time) VALUES (#{city_id}, #{self.id}, '#{@arrival_time}');")
    end

  end

  def destroy
    DB.exec("DELETE FROM trains WHERE id = #{self.id};")
  end

  def cities
    train_cities = []
    results = DB.exec("SELECT city_id, arrival_time FROM trains_cities WHERE train_id = #{self.id}")
    results.each do |result|
      city_id = result['city_id'].to_i
      city = DB.exec("SELECT * FROM cities WHERE id = #{city_id}")
      arrival_time = result['arrival_time']
      name = city.first.fetch('name')
      train_cities.push([City.new({ name: name, id: city_id}), arrival_time])
    end
    train_cities
  end

end
