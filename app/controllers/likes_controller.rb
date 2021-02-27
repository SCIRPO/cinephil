class LikesController < ApplicationController
  def create
    @serie = Serie.find(params[:series_id])
    unless Like.find_by(user: current_user, serie: @serie)
      @like = Like.create(user: current_user, serie: @serie)
    end
    #if request.referer.match? /\Wwhishlist/
      #redirect_to whishlist_path
    #elsif request.referer.match? /\Wseries\/[0-9].*/
      #redirect_to series_path(@serie)

    #else
     # redirect_to series_index_path
    #end
  end

  def destroy
    @serie = Like.find(params[:id]).serie
    Like.find(params[:id]).destroy
    respond_to do |format|
      if request.referer.match? /\Wwhishlist/
        format.html {redirect_to whishlist_path }
        format.js
      elsif request.referer.match? /\Wseries\/[0-9].*/
        format.html {redirect_to series_path(@serie) }
        format.js
      else
        format.html { redirect_to series_index_path }
        format.js
      end
    end

  end
end
