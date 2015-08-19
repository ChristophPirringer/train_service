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

end
