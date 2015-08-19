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
    result = DB.exec("INSERT INTO trains (id, name) VALUES (#{self.id}, '#{self.name}') RETURNING id;")
    @id = result.first.fetch('id').to_i
  end

  def == (another_train)
    another_train.id == self.id &&
    another_train.name == self.name
  end
end
