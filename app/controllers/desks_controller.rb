class DesksController < ApplicationController
  before_action :require_logged_in
  before_action :correct_user, only: [:edit, :update, :destroy]
  
  def index
    @desks = current_user.desks.page(params[:page]).per(10)
  end

  def show
    @desk = current_user.desks.find(params[:id])
  end

  def new
    @desk = current_user.desks.build  # new の form_with 用
  end
  
  def create
    @desk = current_user.desks.build(desk_params)
    if @desk.save
      flash[:success] = "新規の卓を作成しました。"
      redirect_to desks_url
    else
      flash[:danger] = "新規の卓の作成に失敗しました。"
      render :new
    end
  end
  
  def update
    @desk = Desk.find(params[:id])
    if @desk.update(desk_params)
      flash[:success] = "卓の情報は正常に更新されました。"
      redirect_to desks_url
    else
      flash[:danger] = "卓の情報は更新されませんでした。"
      render :edit
    end
  end
  
  def destroy
    @desk.destroy
    flash[:success] = "卓を削除しました。"
    redirect_to desks_url
  end

  private
  
  def desk_params
    params.require(:desk).permit(:name, :overview)
  end
  
  def correct_user
    @desk = current_user.desks.find_by(id: params[:id])
    unless @desk
      redirect_to desks_url
    end
  end
end