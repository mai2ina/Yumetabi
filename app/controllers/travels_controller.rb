class TravelsController < ApplicationController
  before_action :require_logged_in

  def index
    @desk = Desk.find(params[:did])
    @travels = @desk.travels.page(params[:page]).per(15)
  end

  def show
    @travel = Travel.find(params[:id])
    @t_comments = @travel.travel_comments
    @t_comment = @travel.travel_comments.build
    #binding.pry
  end

  def new
    @desk = Desk.find(params[:did])
    @travel = @desk.travels.build  # new の form_with 用
    @travel.travel_images.build
  end

  def create
    @travel = Desk.find(params[:did]).travels.build(travel_params)
    if @travel.save
      flash[:success] = "新規の旅行を作成しました。"
      redirect_to @travel
    else
      @desk = Desk.find(params[:did])
      flash[:danger] = "新規の旅行の作成に失敗しました。"
      render :new
    end
  end

  def edit
    @desk = Desk.find(params[:did])
    @travel = @desk.travels.find_by(id: params[:id])
    if @travel.travel_images.count.zero?
      # ここで build しないと edit で画像アップロード用のフォームが生成できない
      @travel.travel_images.build
    end
  end

  def update
    @travel = Travel.find(params[:id])
    if @travel.update(travel_params)
      flash[:success] = "旅行の情報は正常に更新されました。"
      #redirect_to travels_url
      redirect_back(fallback_location: root_path)
    else
      flash[:danger] = "旅行の情報は更新されませんでした。"
      render :edit
    end
  end
  
  def destroy
    @travel = Travel.find(params[:id])
    @travel.destroy
    flash[:success] = "旅行を削除しました。"
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def travel_params
    params.require(:travel).permit(:name, :country, :prefecture, :city, :starts_on, :ends_on, :want_to_go, :want_to_do, :did, travel_images_attributes: [:image, :id, :_destroy])
  end
end