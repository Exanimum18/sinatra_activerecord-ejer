require_relative "config/application"
require "sinatra"
require "sinatra/reloader"
require "sinatra/activerecord"

get '/' do
  erb :landing
end

get '/restaurants' do
  @restaurants = Restaurant.all
  erb :index
end

get '/restaurants/new' do
    @restaurant = Restaurant.new
    erb :new
end

get '/restaurants/:id/edit' do
  @restaurant = Restaurant.find(params[:id])
  erb :edit
end

patch '/restaurants/:id' do
  @restaurant = Restaurant.find(params[:id])
  @restaurant.update(name: params[:name], city: params[:city], address: params[:address], image_url: params[:image_url])
  redirect to "/restaurants/#{@restaurant.id}"
end

delete '/restaurants/:id' do
  @restaurant = Restaurant.find(params[:id])
  @restaurant.destroy
  redirect to '/restaurants'
end

get '/restaurants/:id' do
  @restaurant = Restaurant.find(params[:id])
  erb :show
end

post '/restaurants' do
  name = params[:name]
  city = params[:city]
  address = params[:address]
  image_url = params[:image_url]
  Restaurant.create(name: name, city: city, address: address, image_url: image_url)
  redirect to '/restaurants'
end
