require 'sinatra'
require 'slim'
require './song'

configure :development do
	DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/development.db")
end

configure :production do
	DataMapper.setup(:default, ENV['DATABASE_URL'])
end

configure do
	enable :sessions
	set :username, 'frank'
	set :password, 'sinatra'
end

get '/' do
	slim :home
end

get '/login' do
	slim :login
end

post '/login' do
	if params[:username] == settings.username && params[:password] == settings.password
		session[:admin] = true
		redirect to('/songs')
	else
		slim :login
	end
end


get '/about' do
	@title = "All About This Website"
	slim :about
end

get '/contact' do
	slim :contact
end

not_found do
	slim :not_found
end