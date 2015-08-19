require 'sinatra'
require './lib/train'
require './lib/city'
require 'pg'
require 'sinatra/reloader'

DB = PG.connect({dbname: 'train_system'})

get '/'  do
	erb(:index)
end

get '/trains' do
	@trains = Train.all
	erb(:trains)
end

post '/trains' do
	@train = Train.new({ id: nil, name: params['name'] })
	@train.save
	redirect(:trains)
end

post '/cities' do
	@city = City.new({id: nil, name: params['name']})
	@city.save
	redirect(:cities)
end

get '/cities' do
	@cities = City.all
	erb(:cities)
end

get '/trains/new' do
	erb(:trains_form)
end

get '/cities/new' do
	erb(:cities_form)
end

get '/train/:id' do
	@train = Train.find(params['id'].to_i)
	erb(:train)
end

get '/city/:id' do
	@city = City.find(params['id'].to_i)
	erb(:city)
end
