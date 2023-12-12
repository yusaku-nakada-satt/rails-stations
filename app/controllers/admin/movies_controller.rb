module Admin
  class MoviesController < ApplicationController
    def index
      @movies = Movie.all
    end

    def new
      @movie = Movie.new()
    end

    def create
      @movie = Movie.new(movie_params)
      if @movie.valid?
        begin
          @movie.save!
          redirect_to admin_movies_path
        rescue ActiveRecord::StatementInvalid => e
          flash[:error] = 'DBエラーです'
          render :new
        end
      else
        render :new
      end
    end

    private
    def movie_params
      params.require(:movie).permit(:name, :year, :is_showing, :description, :image_url)
    end
  end
end