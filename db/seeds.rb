# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'
require 'open-uri'
require 'json'

puts 'Creating 1 fake series & users...'

Serie.destroy_all
Season.destroy_all
Episode.destroy_all
User.destroy_all

5.times do
  user = User.new(
    username:    Faker::FunnyName.name,
    email: Faker::Internet.email,
    password: 'password'
      )
  user.save!
end
puts 'User Finished!'

series_seed = [82856,1399,1426,61664]

key = ENV['TMDB_API_KEY']
series_id = series_seed.each do |serie|
  series_url = "https://api.themoviedb.org/3/tv/#{serie}?api_key=#{key}"
  series_serialized = open(series_url).read
  series = JSON.parse(series_serialized)

  new_serie = Serie.create(
    title: series['name'],
    synopsis: series['overview'],
    genre: series['genres'].map do |genre|
            genre['name']
          end,
    platform: series['networks'].map do |network|
    network['name']
    end
    )
  new_serie.save!
    series['seasons'].each do |season|
      new_season = Season.new(
        title: season['name'],
        season_number: season['season_number'],
        synopsis: season['overview'])
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
                  synopsis: episode['overview'],
                  duration: episode['air_date']
                )
                new_ep.season = new_season
                new_ep.save!
              end
            end
  end

end































# 5.times do
#   new_serie = Serie.create(
#     title: Faker::Movie.title,
#     synopsis: Faker::Movie.quote,
#     genre: "drama",
#     platform: "Netflix",
#     )
#   3.times do  |index|
#     new_season = Season.new(title: Faker::Movie.title, season_number: index , synopsis: Faker::Movie.quote)
#     new_season.serie = new_serie
#     new_season.save!
#       8.times do  |index|
#         new_ep = Episode.new(episode_number: index, title: Faker::Movie.title, synopsis: Faker::Movie.quote, duration: Faker::Number.number(digits: 2))
#         new_ep.season = new_season
#         new_ep.save!
#       end
#   end
# end



puts 'Series Finished!'
