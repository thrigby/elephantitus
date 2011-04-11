require 'sinatra'
require 'erb'

require File.dirname(__FILE__) + "/elephant"

get '/' do
  redirect "/elephants"
end

get '/elephants' do
  @elephants = Elephant.find_all
  erb :index
end

post '/elephants' do 
  Elephant.create(params["name"], params["color"], params["weight"])
  redirect "/elephants"
end

delete "/elephants/:id" do |id|
  @elephant = Elephant.find(id)
  @elephant.destroy if @elephant
  redirect "/elephants"
end

put "/elephants/:id" do |id|
end

get'/elephants/:id' do |id|
  @elephant = Elephant.find(id)
  erb :show
end
