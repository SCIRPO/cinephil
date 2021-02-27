class ViewingsController < ApplicationController
  def index
    @viewings = current_user.viewings
  end

  def show
    @viewing = Viewing.find(params[:id])
  end

  def create
    @viewable = params[:viewable_type].constantize.find(params[:viewable_id])
    @viewing = Viewing.create(user: current_user, viewable: @viewable)
    @viewing.save

    respond_to do |format|
      if @viewing.viewable_type == "Serie"
        format.html { redirect_to whishlist_path }
        format.js
      else
        format.html { redirect_to series_path(@viewable.serie) }
        format.js
      end
    end
    
  end

  def update
    @viewing = Viewing.find(params[:id])
    @viewing.rating = params[:viewing][:rating]
    @viewing.user = current_user
    @viewing.save
    redirect_to library_path(anchor: "edit_viewing_#{@viewing.id}")
  end

  def destroy
    @viewing = Viewing.find(params[:id])
    @viewable = @viewing.viewable
    @viewing.destroy

    respond_to do |format|
      if @viewing.viewable_type == "Serie"
        format.html { redirect_to series_path(@viewable) }
        format.js
      else
        format.html { redirect_to series_path(@viewable.serie) }
        format.js
      end
    end
  end
end
