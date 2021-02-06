class ViewingsController < ApplicationController
  def create
    @episode = Episode.find(params[:episodes_id])
    Viewing.create(user: current_user, episode: @episode)
  end
end
