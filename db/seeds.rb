# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'
require "open-uri"

puts 'Creating 5 fake series & users...'

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


5.times do 
  new_serie = Serie.create(
    title: Faker::Movie.title,
    synopsis: Faker::Movie.quote,
    genre: "drama",
    platform: "Netflix",
    )
  3.times do  |index|
    new_season = Season.new(title: Faker::Movie.title, season_number: index , synopsis: Faker::Movie.quote)
    new_season.serie = new_serie
    new_season.save!
      8.times do  |index|
        new_ep = Episode.new(episode_number: index, title: Faker::Movie.title, synopsis: Faker::Movie.quote, duration: Faker::Number.number(digits: 2))
        new_ep.season = new_season
        new_ep.save!
      end
  end
end

puts 'Series Finished!'