class RoomsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @rooms = current_user.rooms  # ログイン中のユーザーが作成した施設を表示
  end

  def all_rooms
    @rooms = Room.all # 全ユーザーのルームを表示
  end

  def show
    @room = Room.find(params[:id])
  end

  def new
    @room = Room.new
  end

  def create
    @room = current_user.rooms.build(room_params)
    if @room.save
      redirect_to rooms_path, notice: '施設が作成されました。'
    else
      render :new
    end
  end

  def search
    @area = params[:area]
    @keyword = params[:keyword]

    # エリア検索
    @rooms = Room.all
    if @area.present? && %w[東京 大阪 京都 札幌].include?(@area)
      @rooms = @rooms.where("address LIKE ?", "%#{@area}%")
    end

    # フリーワード検索
    if @keyword.present?
      @rooms = @rooms.where("name LIKE ? OR description LIKE ?", "%#{@keyword}%", "%#{@keyword}%")
    end

    @total_count = @rooms.count
  end

  private

  def room_params
    params.require(:room).permit(:name, :description, :price_per_day, :address, :image)
  end
end
