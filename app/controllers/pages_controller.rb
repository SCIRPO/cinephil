class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def whishlist
    @likes = current_user.likes.where(viewed:false)
  end

  def view
    @views = current_user.likes.where(viewed:true)
  end
end
