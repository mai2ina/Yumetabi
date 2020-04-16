class FavoritesController < ApplicationController
  def create
    travel = Travel.find(params[:travel_id])
    current_user.like(travel)
    flash[:success] = 'お気に入りに追加しました。'
    redirect_to current_user  #どこにリダイレクトする？
  end

  def destroy
    travel = Travel.find(params[:travel_id])
    current_user.dislike(travel)
    flash[:success] = 'お気に入りから削除しました。'
    redirect_to current_user  #どこにリダイレクトする？
  end
end
