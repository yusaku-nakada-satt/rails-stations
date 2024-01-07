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
        begin
          @schedule.save!
          redirect_to admin_schedules_path
        rescue ActiveRecord::StatementInvalid => e
          flash[:error] = 'DBエラーです'
          render :new
        end
      else
        render :new
      end
    end


    def update
      @schedule = Schedule.find(params[:id])
      if @schedule.update(schedule_params)
        redirect_to admin_schedules_path
      else
        flash[:error] = 'DBエラーです'
        render :edit
      end
    end

    def destroy
      @schedule = Schedule.find(params[:id])
      if @schedule.destroy
        flash[:notice] = '削除しました'
        redirect_to admin_schedules_path
      else
        flash[:error] = '削除に失敗しました。'
        render :index
      end
    end

    private

    def schedule_params
      params.require(:schedule).permit(:movie_id, :start_time, :end_time)
    end
  end
end
