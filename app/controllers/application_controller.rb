class ApplicationController < ActionController::Base
  include SessionsHelper

  private
  
  def require_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end

  def counts(user)
    # ユーザが登録した旅行数、フォロー数、フォロワー数、お気に入り旅行数を取得
    @count_travels = user.desks.map{ |desk| desk.travels.size }.inject(:+)
    @count_followings = user.followings.count
    @count_followers = user.followers.count
    @count_likes = user.liked.count
  end
end
