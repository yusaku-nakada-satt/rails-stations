module Admin
  class SchedulesController < ApplicationController
    def index
      @schedules = Schedule.joins(:movie).select('schedules.*, movies.name', 'movies.image_url')
    end

    def show
      @movie = Movie.where(id: Schedule.find(params[:id]).movie_id).first
      @schedules = Schedule.where(movie_id: @movie.id)
    end

    def new
      @schedule = Schedule.new
    end

    def edit
      @schedule = Schedule.find(params[:id])
    end

    def create
      @schedule = Schedule.new(schedule_params)
      if @schedule.valid?
        @schedule.save!
          redirect_to admin_schedules_path
          render :new
          return
      else
        flash[:error] = I18n.t('bd.db_error')
        render :new
      end
    end


    def update
      @schedule = Schedule.find(params[:id])
      if @schedule.update(schedule_params)
        redirect_to admin_schedules_path
      else
        flash[:error] = I18n.t('bd.db_error')
        render :edit
      end
    end

    def destroy
      @schedule = Schedule.find(params[:id])
      if @schedule.destroy
        flash[:notice] = I18n.t('bd.delete_success')
        redirect_to admin_schedules_path
      else
        flash[:error] = I18n.t('bd.delete_error')
        render :index
      end
    end

    private

    def schedule_params
      params.require(:schedule).permit(:movie_id, :start_time, :end_time, :theater_id)
    end
  end
end
