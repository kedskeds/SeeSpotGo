class ReservationsController < ApplicationController
  def create
    @reservation = Reservation.create(reservation_params)
    redirect_to space_path(@reservation.space_id)
  end

  def reservation_params
    params.require(:reservation).permit(:start_time, :end_time).merge(space_id: params[:space_id], occupant_id: current_user.id)
  end
end