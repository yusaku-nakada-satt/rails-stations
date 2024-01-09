module Admin
  class ReservationsController < ApplicationController
    def index
      @reservations = Reservation.joins(:sheet).joins(schedule: :movie).select(
        'reservations.*,  sheets.id AS sheets_id', 'movies.id AS movies_id'
      )
    end

    def show
      @reservation = Reservation.joins(:sheet).joins(schedule: :movie).select('reservations.*, sheets.id AS sheet_id',
                                                                              'movies.id AS movie_id').find(params[:id])
    end
    def new
      @reservation = Reservation.new
      if @reservation
        flash[:notice] = I18n.t('reservations.create_success')
      else
        flash[:error] = I18n.t('db.db_error')
        render :new
      end
    end

    def create
      @reservation = Reservation.new(reservation_params)
      @movie = Movie.find_by(params[:reservation][:movie_id])
      @reservation_sheet = Reservation.find_by(date: reservation_params[:date],
                                               sheet_id: reservation_params[:sheet_id],
                                               schedule_id: reservation_params[:schedule_id])

      if @reservation_sheet
        flash.now[:error] = I18n.t('reservations.already_reserved')
        render :new, status: :bad_request
        return
      end

      if @reservation.valid?
        if @reservation.save
          redirect_to admin_reservations_path
        else
          flash.now[:error] = I18n.t('bd.db_error')
          render :new, status: :bad_request
          nil
        end
      else
        flash[:error] = I18n.t('bd.db_error')
        render :new, status: :bad_request
        nil
      end
    end


    def update
      @reservation = Reservation.find(params[:id])
      if @reservation.update(reservation_params)
        redirect_to admin_reservations_path
      else
        flash[:error] = I18n.t('bd.db_error')
        render :edit, status: :bad_request
      end
    end

    def destroy
      @reservation = Reservation.find(params[:id])
      if @reservation.destroy
        flash[:notice] = I18n.t('bd.delete_success')
        redirect_to admin_reservations_path
      else
        flash[:error] = I18n.t('bd.delete_error')
        render :index
      end
    end

    private

    def reservation_params
      params.require(:reservation).permit(:sheet_id, :schedule_id, :email, :name, :date)
    end
  end
end
