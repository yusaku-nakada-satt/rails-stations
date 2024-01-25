class ReservationsController < ApplicationController
  def new
    redirect_to movies_path unless params[:sheet_id] && params[:date]

    @reservation = Reservation.new
    @movie = Movie.find_by(params[:movie_id])
    @theater = Theater.find_by(params[:theater_id])
  end

  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.screen_id = @screen_id
    @movie = Movie.find_by(params[:reservation][:movie_id])
    @reservation_sheet = Reservation.find_by(date: reservation_params[:date],
                                             sheet_id: reservation_params[:sheet_id],
                                             schedule_id: reservation_params[:schedule_id],
                                             theater_id: reservation_params[:theater_id],
                                             screen_id: reservation_params[:screen_id])

    if @reservation_sheet
      flash[:error] = I18n.t('reservations.already_reserved')
      redirect_to movie_reservation_path(params[:reservation][:movie_id],
                                         date: reservation_params[:date],
                                         schedule_id: reservation_params[:schedule_id])
      return
    end

    if @reservation.valid?
      @reservation.save!
      ReservationMailer.with(reservation: @reservation).reservation_email.deliver_later
      redirect_to movies_path, notice: I18n.t('reservations.reservation_completed')
    else
      flash[:error] = I18n.t('db.db_error')
      redirect_to new_movie_schedule_reservation_path(params[:reservation][:movie_id], reservation_params[:schedule_id]),
                  params: reservation_params
    end
  end


  private

  def reservation_params
    params.require(:reservation).permit(:date, :sheet_id, :schedule_id, :email, :name, :theater_id)
  end
end
