class ReservationsController < ApplicationController


    def index
        @columns = Sheet.select(:column).distinct
        @rows = Sheet.select(:row).distinct
    end

    def create
        @reservation = Reservation.new(params)
        if @reservation.valid?
            begin
                @reservation.save!
                redirect_to root_path
            rescue ActiveRecord::StatementInvalid => e
                flash[:error] = 'DBエラーです'
                redirect_to root_path
            end
        else
            flash[:error] = 'DBエラーです'
            redirect_to root_path
        end
    end

    def new
        @reservation = Reservation.new
    end
end
