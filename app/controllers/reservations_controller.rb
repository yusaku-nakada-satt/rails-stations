
class ReservationsController < ApplicationController

    def create
        @reservation = Reservation.new(reservation_params)

        if @reservation.valid?
            begin
                @reservation.save!
                redirect_to movies_path, notice: '予約が完了しました'
            rescue ActiveRecord::StatementInvalid => e
                flash[:error] = 'DBエラーです'
                render :new
            end
        else
            flash[:error] = 'DBエラーです'
            render :new
        end
    end

    def new
        unless  params[:sheet_id] && params[:date]
            redirect_to movies_path
        end


        @reservation = Reservation.new
        @movie = Movie.find(params[:movie_id])
    end

    private
    def reservation_params
        params.require(:reservation).permit(:date, :sheet_id, :schedule_id, :name, :email)
    end
end

