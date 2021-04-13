require 'faker'
require 'open-uri'
require 'json'

puts 'Destroying everything'

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

test_user = User.new(
  username: 'test',
  email: 'test@test.fr',
  password: 'password'
  )
test_user.save!

puts 'User created!'

puts 'Fetching from API series and associated seasons and episodes'

# series_seed = [82856,1399,1426,61664,46639,74204,40008,87739,1396,76479,1835,1409,91875,71446,71578,91239,900,42009,72750,1981,88408,62699,1425,70523,67178,78191,67744,96677,81354]
# series_seed = [82856]



key = ENV['TMDB_API_KEY']

url = "https://api.themoviedb.org/3/tv/airing_today?api_key=#{key}&language=en-US&page=1"
tv_show_serialized = open(url).read
tv_shows = JSON.parse(tv_show_serialized)
series_seed = tv_shows['results'].map do |serie|
    serie = serie['id']
    series_url = "https://api.themoviedb.org/3/tv/#{serie}?api_key=#{key}"
    series_serialized = open(series_url).read
    series = JSON.parse(series_serialized)
    new_serie = Serie.new(
    title: series['name'],
    synopsis: series['overview'],
    release_date: series['first_air_date'],
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

puts 'Series, seasons, episodes created!'
