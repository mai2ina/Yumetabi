class TravelCommentsController < ApplicationController
  def create
    #binding.pry
    @travel = Travel.find(params[:tid])
    @t_comment = @travel.travel_comments.build(travel_comment_params)
    @t_comment.user_id = current_user.id  # これがないとコメントを送信した User と関連づけできない
    if @t_comment.save
      flash[:success] = "コメントしました。"
      redirect_back(fallback_location: root_path)
    else
      flash[:danger] = "コメントできませんでした。"
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def travel_comment_params
    params.require(:travel_comment).permit(:content)
  end
end
