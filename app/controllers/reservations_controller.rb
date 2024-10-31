class ReservationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @reservations = current_user.reservations.includes(:room)
  end

  def show
    @reservation = Reservation.find(params[:id])
  end

  def new
    @room = Room.find(params[:room_id])
    @reservation = Reservation.new
  end

  def create
    @room = Room.find(params[:room_id])
    @reservation = current_user.reservations.build(reservation_params)
    @reservation.room = @room

    if @reservation.save
      redirect_to reservation_path(@reservation), notice: '予約が完了しました。'
    else
      render :new
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:check_in, :check_out, :guests)
  end
end
