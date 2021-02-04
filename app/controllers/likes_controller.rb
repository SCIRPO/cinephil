class LikesController < ApplicationController
  def create
    @serie = Serie.find(params[:series_id])
    Like.create(user: current_user, serie: @serie)
    redirect_to series_path(@serie)
  end

end
