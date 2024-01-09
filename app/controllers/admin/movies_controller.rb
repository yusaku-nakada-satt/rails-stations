module Admin
  class MoviesController < ApplicationController
    def index
      @movies = Movie.left_joins(:schedules).select('schedules.*, movies.*')
    end

    def show
      @movie = Movie.find(params[:id])
      @schedules = Schedule.where(movie_id: params[:id])
    end

    def new
      @movie = Movie.new
      if @movie
        flash[:notice] = I18n.t('movies.create_success')
      else
        flash[:error] = I18n.t('bd.db_error')
        render :new
      end
    end

    def edit
      @movie = Movie.find(params[:id])
    end

    def create
      @movie = Movie.new(movie_params)
      if @movie.valid?
        @movie.save!
          redirect_to admin_movies_path
          render :new
          return
      else
        flash[:error] = I18n.t('bd.db_error')
        render :new
      end
    end


    def update
      @movie = Movie.find(params[:id])
      if @movie.update(movie_params)
        redirect_to admin_movies_path
      else
        flash[:error] = I18n.t('db.db_error')
        render :edit
      end
    end

    def destroy
      @movie = Movie.find(params[:id])
      if @movie.destroy
        flash[:notice] = I18n.t('db.delete_success')
        redirect_to admin_movies_path
      else
        flash[:error] = I18n.t('db.delete_error')
        render :index
      end
    end

    private
    def movie_params
      params.require(:movie).permit(:name, :year, :is_showing, :description, :image_url)
    end
  end
end
