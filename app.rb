require 'sinatra'
require './lib/train'
require './lib/city'
require 'pg'
require 'sinatra/reloader'
require 'pry'

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

delete '/city/:id' do
	@city = City.find(params['id'].to_i)
	@city.destroy
	redirect(:cities)
end

patch '/city/:id' do
	@city = City.find(params['id'].to_i)
	@city.update({name: params['name']})
	redirect(:cities)
end

delete '/train/:id' do
	@train = Train.find(params['id'].to_i)
	@train.destroy
	redirect(:trains)
end

patch '/train/:id' do
	@train = Train.find(params['id'].to_i)
	@train.update(params)
	redirect(:trains)
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

get '/city/:id/edit' do
	@city = City.find(params['id'].to_i)
	erb(:city_edit)
end

get '/train/:id/edit' do
	@train = Train.find(params['id'].to_i)
	erb(:train_edit)
end
