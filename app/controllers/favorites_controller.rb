class FavoritesController < ApplicationController
  def create
    travel = Travel.find(params[:travel_id])
    current_user.like(travel)
    flash[:success] = 'お気に入りに追加しました。'
    redirect_back(fallback_location: root_path)
    # redirect_to current_user  #どこにリダイレクトする？
  end

  def destroy
    travel = Travel.find(params[:travel_id])
    current_user.dislike(travel)
    flash[:success] = 'お気に入りから外しました。'
    redirect_back(fallback_location: root_path)
    # redirect_to current_user  #どこにリダイレクトする？
  end
end
