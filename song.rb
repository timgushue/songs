require 'dm-core'
require 'dm-migrations'

configure :development do
	DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/development.db")
end

class Song
	include DataMapper::Resource
	property :id, Serial
	property :title, String
	property :lyrics, Text
	property :length, Integer
	property :released_on, Date 

	def released_on=date
		super Date.strptime(date, '%m/%d/%Y')
	end
end

DataMapper.finalize

# /songs
get '/songs' do
	@songs = Song.all
	slim :songs
end

post '/songs' do
	song = Song.create(params[:song])
	redirect to("/songs/#{song.id}")
end

# /songs/new
get '/songs/new' do
	halt(401, 'Not Authorized') unless session[:admin]
	@song = Song.new
	slim :new_song
end

# songs/:id
get '/songs/:id' do
	@song = Song.get(params[:id])
	slim :show_song
end

put '/songs/:id' do
	song = Song.get(params[:id])
	song.update(params[:song])
	redirect to("/songs/#{song.id}")
end

delete '/songs/:id' do
	song.get(params[:song]).destroy
	redirect to("/songs")
end

get '/songs/:id/edit' do
	@song = Song.get(params[:id])
	slim :show_song
end









