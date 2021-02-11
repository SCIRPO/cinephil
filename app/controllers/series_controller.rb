class SeriesController < ApplicationController

  def index
    @series = Serie.all
  end

  def show
    @serie = Serie.find(params[:id])
    
  end

  def viewed
    # find the serie
    serie= Serie.find(params["serie"])
    
    # find the like associate, and update the viewed param 
    like = serie.likes.find_by(user:current_user)
    
    like.viewed = true
    like.save
    #like.update(viewed:true)


    # create all the viewing for each episodes
    serie.seasons.each do |season|
      season.episodes.each do |episode|
        Viewing.new(episode: episode, user: current_user)
        end
    end
  end

end
