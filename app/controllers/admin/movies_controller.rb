module Admin
  class MoviesController < ApplicationController
    def index
      @movies = Movie.all
    end

    def new
      if @movie = Movie.new()
        flash[:notice] = "新規作成しました"
      else
        flash[:error] = 'DBエラーです'
        render :new
      end
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

    def edit
      @movie = Movie.find(params[:id])
    end

    def update
      @movie = Movie.find(params[:id])
      if @movie.update(movie_params)
        redirect_to admin_movies_path
      else
        flash[:error] = 'DBエラーです'
        render :edit
      end
    end

    def destroy
      @movie = Movie.find(params[:id])
      if @movie.destroy
        flash[:notice] = "削除しました"
        redirect_to admin_movies_path
      else
        flash[:error] = '削除に失敗しました。'
        render :index
      end
    end
    

    private
    def movie_params
      params.require(:movie).permit(:name, :year, :is_showing, :description, :image_url)
    end
  end
end