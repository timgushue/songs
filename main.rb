require 'sinatra'
require 'slim'
require 'sinatra/flash'
require 'pony'
require 'v8'
require 'coffee-script'
require './email'
require './sinatra/auth'
require './song'


configure :development do
	DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/development.db")
end

configure :production do
	DataMapper.setup(:default, ENV['DATABASE_URL'])
end

helpers do
	def current?(path='/')
		(request.path==path || request.path==path+'/') ? "current" : nil
	end
end

get('/js/application.js'){coffee :application}

get '/' do
	slim :home
end

get '/about' do
	@title = "All About This Website"
	slim :about
end

get '/contact' do
	slim :contact
end

post '/contact' do
	send_message
	flash[:message] = "Thanks for your message."
	redirect to('/')
end

not_found do
	slim :not_found
end


