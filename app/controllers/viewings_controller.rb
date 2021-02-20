class ViewingsController < ApplicationController
  def index
    @viewings = Viewing.current_user.all
  end

  def create
    @viewable = params[:viewable_type].constantize.find(params[:viewable_id])
    @viewing = Viewing.create(user: current_user, viewable: @viewable)
    @viewing.save
    redirect_to series_path(@viewable)
  end

  def update
    @viewable = params[:viewable_type].constantize.find(params[:viewable_id])
    @viewing = Viewing.find(params[:viewable_id])
    @viewing.rating = params[:rating]
    @viewing.save
    redirect_to series_path(@viewable)
  end

  def destroy
    @viewing = Viewing.find(params[:id])
    @viewable = @viewing.viewable
    @viewing.destroy
    redirect_to series_path(@viewable)
  end
end
