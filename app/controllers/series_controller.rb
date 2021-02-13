class SeriesController < ApplicationController

  def index
    @series = Serie.all
    if params[:name_query].present?
      sql_query = "title ILIKE :name_query"
      @series = @series.where(sql_query, name_query: "%#{params[:name_query]}%")
    end
    if params[:genre_query].present?
      sql_query = ":strict_query = ANY (genres)"
      @series = @series.where(sql_query, strict_query: "#{params[:genre_query]}")
    end
    if params[:platform_query].present?
      sql_query = ":strict_query = ANY (platforms)"
      @series = @series.where(sql_query, strict_query: "#{params[:platform_query]}")
    end
  end

  def show
    @serie = Serie.find(params[:id])
    
  end

  def viewed
    # find the serie
    serie = Serie.find(params["serie"])

    # find the like associate, and update the viewed param
    like = serie.likes.find_by(user: current_user)

    like.viewed = true
    like.save
    # like.update(viewed:true)

    # create all the viewing for each episodes
    serie.seasons.each do |season|
      season.episodes.each do |episode|
        Viewing.new(episode: episode, user: current_user)
      end
    end
    redirect_to whishlist_path
  end

  def series_params
    params.require(:serie).permit(:photo)
  end
end

