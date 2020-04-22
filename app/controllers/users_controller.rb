class UsersController < ApplicationController
  before_action :require_logged_in, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]

  def show
    @user = User.find_by(id: params[:id])
    if @user.nil?
      redirect_to current_user
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "ユーザを登録しました。"
      redirect_to @user
    else
      flash[:danger] = "ユーザの登録に失敗しました。"
      render :new
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    #binding.pry
    if @user.update(user_params)
      flash[:success] = "プロフィールは正常に更新されました。"
      redirect_to @user
    else
      flash[:danger] = "プロフィールは更新されませんでした。"
      render :edit
    end
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmationv, :image, :biography)
  end
  
  def correct_user
    # 編集したいユーザとログイン中のユーザが一致しない場合は編集させない
    unless current_user == User.find_by(id: params[:id])
      redirect_to current_user
    end
  end
end
