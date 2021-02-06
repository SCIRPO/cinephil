require 'faker'
require 'open-uri'
require 'json'

puts 'Detroying everything'

Serie.destroy_all
Season.destroy_all
Episode.destroy_all
User.destroy_all

puts 'Everything destroyed'

puts 'Creating users...'

5.times do
  user = User.new(
    username:    Faker::FunnyName.name,
    email: Faker::Internet.email,
    password: 'password'
      )
  user.save!
end

puts 'User created!'

puts 'Fetching from API series and associated seasons and episodes'

series_seed = [82856,1399,1426,61664]

key = ENV['TMDB_API_KEY']
series_id = series_seed.each do |serie|
  series_url = "https://api.themoviedb.org/3/tv/#{serie}?api_key=#{key}"
  series_serialized = open(series_url).read
  series = JSON.parse(series_serialized)
  new_serie = Serie.new(
    title: series['name'],
    synopsis: series['overview'],
    genres: series['genres'].map { |genre| genre['name'] },
    platforms: series['networks'].map { |network| network['name']}
  )
  poster_url = "https://image.tmdb.org/t/p/original/#{series['poster_path']}"
  file = URI.open(poster_url)
  new_serie.photo.attach(io: file, filename: 'poster.jpg', content_type: 'image/jpg')
  new_serie.save!
  series['seasons'].each do |season|
    new_season = Season.new(
      title: season['name'],
      season_number: season['season_number'],
      synopsis: season['overview']
    )
    new_season.serie = new_serie
    new_season.save!
    # Get episodes
    series['seasons'].each do |season|
      season_url = "https://api.themoviedb.org/3/tv/#{serie}/season/#{season['season_number']}?api_key=#{key}"
      season_serialized = open(season_url).read
      season = JSON.parse(season_serialized)

      season['episodes'].each do |episode|
        new_ep = Episode.new(
          episode_number: episode['episode_number'],
          title: episode['name'],
          synopsis: episode['overview']
        )
        new_ep.season = new_season
        new_ep.save!
      end
    end
  end
end

puts 'Series, seasons, episodes created!'
