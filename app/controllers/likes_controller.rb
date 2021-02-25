class LikesController < ApplicationController
  def create
    @serie = Serie.find(params[:series_id])
    unless Like.find_by(user: current_user, serie: @serie)
      Like.create(user: current_user, serie: @serie)
    end
    if request.referer.match? /\Wwhishlist/
      redirect_to whishlist_path
    elsif request.referer.match? /\Wseries\/[0-9].*/
      redirect_to series_path(@serie)

    else
      redirect_to series_index_path
    end
  end

  def destroy
    @serie = Like.find(params[:id]).serie
    Like.find(params[:id]).destroy
    if request.referer.match? /\Wwhishlist/
      redirect_to whishlist_path
    elsif request.referer.match? /\Wseries\/[0-9].*/
      redirect_to series_path(@serie)
    else
      redirect_to series_index_path
    end
  end
end
