require 'sinatra'
require 'slim'
require './song'


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

not_found do
	slim :not_found
end