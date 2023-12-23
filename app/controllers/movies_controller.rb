class MoviesController < ApplicationController

  def index

    if movie_search_params[:keyword].blank? && movie_search_params[:is_showing].blank?
      @movies = Movie.all
    end

    if movie_search_params[:keyword].present? && movie_search_params[:is_showing].present?
      @movies = Movie.where('name LIKE :keyword OR description LIKE :keyword', keyword: "%#{movie_search_params[:keyword]}%")
        .and Movie.where(is_showing: movie_search_params[:is_showing])
    elsif movie_search_params[:is_showing].present?
      @movies = Movie.where(is_showing: movie_search_params[:is_showing])
    else
      @movies = Movie.where('name LIKE :keyword OR description LIKE :keyword', keyword: "%#{movie_search_params[:keyword]}%")
    end
  end

  def show
    @movie = Movie.find(params[:id])
    @schedules = @movie.schedules
    @dates = (Date.today..Date.today + 6).to_a
  end

  private
  def movie_search_params
    params.permit(:keyword, :is_showing)
  end

end
