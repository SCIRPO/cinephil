class LikesController < ApplicationController
  def create
    @serie = Serie.find(params[:series_id])
    unless Like.find_by(user: current_user, serie: @serie)
      Like.create(user: current_user, serie: @serie)
    end
    redirect_to series_path(@serie)
  end

  def destroy
    Like.find(params[:id]).destroy
    redirect_to whishlist_path
  end
end
