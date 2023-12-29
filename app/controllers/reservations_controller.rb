
class ReservationsController < ApplicationController

    def create
        @reservation = Reservation.new(reservation_params)
        @movie = Movie.find_by(params[:reservation][:movie_id])
        @reservation_sheet = Reservation.find_by(date: reservation_params[:date], sheet_id: reservation_params[:sheet_id], schedule_id: reservation_params[:schedule_id])
        
        if @reservation_sheet
            flash[:error] = 'その席はすでに予約されています'
            redirect_to movie_reservation_path(params[:reservation][:movie_id], date: reservation_params[:date], schedule_id: reservation_params[:schedule_id])
            return
        end

        if @reservation.valid?
            @reservation.save!
            redirect_to movies_path, notice: '予約が完了しました'
        else
            flash[:error] = 'DBエラーです'
            redirect_to new_movie_schedule_reservation_path(params[:reservation][:movie_id], reservation_params[:schedule_id]), params: reservation_params
        end

    end

    def new
        unless  params[:sheet_id] && params[:date]
            redirect_to movies_path
        end


        @reservation = Reservation.new
        @movie = Movie.find_by(params[:movie_id])
    end

    private
    def reservation_params
        params.require(:reservation).permit(:date, :sheet_id, :schedule_id, :email, :name)
    end
end

