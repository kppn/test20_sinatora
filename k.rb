require 'sinatra'
require 'sinatra/reloader'

set :bind, '172.16.1.2'


require_relative 'models/user'



get '/' do
  @title = 'sinatra'
  @message = 'hello, world'
  erb :index
end

get '/post' do
  @title = 'sinatra *Nantyatte* user database'
  @message = 'please post your name'

  @users = User.all
  erb :post
end


post '/post' do
  @title = 'testing'
  @message = 'please post your name'

  puts "----------- #{params} "
  if params[:id]
    User.delete!(params[:id])
    @users = User.all
    break erb :post
  end

  if params[:name].empty?
    @users = User.all
    break erb :post
  end

  user = User.new(params[:name])
  puts "----------- user #{user.name} #{user.id} "
  user.save!

  @users = User.all
  erb :post
end



