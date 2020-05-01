class UsersController < ApplicationController
  before_action :require_logged_in, only: [:show, :edit, :update, :destroy]
  before_action :confirm_logged_in, only: [:new]
  before_action :correct_user, only: [:edit, :update]

  def show
    @user = User.includes(:desks => :travels).find_by(id: params[:id])
    if @user.nil?
      redirect_to current_user
    else
      counts(@user)
      @desks = @user.desks.select(:id, :name)
      @travels = @user.desks.map{ |desk| desk.travels }.flatten
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
    current_user.destroy
    redirect_to root_url
  end

  def travellists
    @user = User.includes(:desks => :travels).find(params[:id])
    @desks = @user.desks.select(:id, :name)
    @travels = @user.desks.map{ |desk| desk.travels }.flatten
    counts(@user)
  end

  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.page(params[:page])
    counts(@user)
  end
  
  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.page(params[:page])
    counts(@user)
  end
  
  def likes
    @user = User.find(params[:id])
    @desks = @user.desks.select(:id, :name)
    @favorites = @user.liked.page(params[:page])
    counts(@user)
  end

  def search
    @users = User.search(params[:name]).page(params[:page])
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image, :biography)
  end
  
  def correct_user
    # 編集したいユーザとログイン中のユーザが一致しない場合は編集させない
    unless current_user == User.find_by(id: params[:id])
      redirect_to current_user
    end
  end
end
