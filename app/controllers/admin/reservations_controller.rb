module Admin
  class ReservationsController < ApplicationController
    def index
      @reservations = Reservation.joins(:sheet).joins(schedule: :movie).select('reservations.*,  sheets.id AS sheets_id', 'movies.id AS movies_id')
    end

    def new
      if @reservation = Reservation.new
        flash[:notice] = "新規作成しました"
      else
        flash[:error] = 'DBエラーです'
        render :new
      end
    end

  def create
    @reservation = Reservation.new(reservation_params)
    @movie = Movie.find_by(params[:reservation][:movie_id])
    @reservation_sheet = Reservation.find_by(date: reservation_params[:date], sheet_id: reservation_params[:sheet_id], schedule_id: reservation_params[:schedule_id])
  
    if @reservation_sheet
        flash[:error] = 'その席はすでに予約されています'
        render :new, status: 400
        return
    end
    
    if @reservation.valid?
      if @reservation.save
        redirect_to admin_reservations_path
      else
        flash[:error] = 'DBエラーです'
        render :new, status: 400
        return
      end
    else
      flash[:error] = 'DBエラーです'
      render :new, status: 400
      return
    end
  end

  def show

    
    @reservation = Reservation.joins(:sheet).joins(schedule: :movie).select('reservations.*, sheets.id AS sheet_id', 'movies.id AS movie_id').find(params[:id])
  end

  def update
    @reservation = Reservation.find(params[:id])
    if @reservation.update(reservation_params)
      redirect_to admin_reservations_path
    else
      flash[:error] = 'DBエラーです'
      render :edit, status: 400
    end
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    if @reservation.destroy
      flash[:notice] = "削除しました"
      redirect_to admin_reservations_path
    else
      flash[:error] = "削除に失敗しました。"
      render :index
    end
  end

  private
    def reservation_params
        params.require(:reservation).permit(:sheet_id, :schedule_id, :email, :name, :date)
    end
  end
end