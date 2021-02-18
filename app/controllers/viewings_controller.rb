class ViewingsController < ApplicationController
  def index
    @viewings = Viewing.current_user.all
  end

  def create
    @viewable = params[:viewable_type].constantize.find(params[:viewable_id])
    @viewing = Viewing.create(user: current_user, viewable: @viewable)
    @viewing.save
    redirect_to @viewable.serie
  end

  def update
    @viewing = Viewing.find(params[:id])
    @viewing.rating = params[:rating]
    @viewing.save
    redirect_to @viewing.serie
  end

  def destroy
    @viewing = Viewing.find(params[:id])
    @viewing.destroy
    redirect_to @viewing.serie
  end
end
