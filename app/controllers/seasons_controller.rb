class SeasonsController < ApplicationController
  def index
    @seasons = Season.all
  end

  def show
    @seasons = Season.find(params[:id])
  end
end
