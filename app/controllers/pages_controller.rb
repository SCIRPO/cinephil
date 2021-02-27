class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def whishlist
    @all_likes = current_user.likes
    @viewed_likes =  current_user.likes
                                 .joins(user: [ :viewings ])
                                 .where(viewings: {viewable_type: "Serie"})
                                 .where("viewings.viewable_id = likes.serie_id")
    
    # Equivalent en SQL :
    # Tous les séries qui sont liked ET viewed
    #   SELECT COUNT(*) FROM "likes"
    #   INNER JOIN "users" ON "users"."id" = "likes"."user_id"
    #   INNER JOIN "viewings" ON "viewings"."user_id" = "users"."id"
    #   WHERE "likes"."user_id" = current_user.id
    #   AND "viewings"."viewable_type" = "Serie"
    #   AND (viewings.viewable_id = likes.serie_id)

    @likes = @all_likes - @viewed_likes
  end

  def view
    @views = current_user.likes
  end

  def library
    @viewings = current_user.viewings.order(created_at: :desc)
  end
end
