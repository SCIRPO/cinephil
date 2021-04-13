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

  def series_params
    params.require(:serie).permit(:photo)
  end
end

