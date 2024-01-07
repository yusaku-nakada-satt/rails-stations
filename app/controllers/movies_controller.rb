class MoviesController < ApplicationController
  def index
    @movies = Movie.all if movie_search_params[:keyword].blank? && movie_search_params[:is_showing].blank?

    @movies = if movie_search_params[:keyword].present? && movie_search_params[:is_showing].present?
                Movie.where('name LIKE :keyword OR description LIKE :keyword',
                            keyword: "%#{movie_search_params[:keyword]}%")
                  .and Movie.where(is_showing: movie_search_params[:is_showing])
              elsif movie_search_params[:is_showing].present?
                Movie.where(is_showing: movie_search_params[:is_showing])
              else
                Movie.where('name LIKE :keyword OR description LIKE :keyword',
                            keyword: "%#{movie_search_params[:keyword]}%")
              end
  end

  def show
    @movie = Movie.find(params[:id])
    @schedules = @movie.schedules
    @dates = (Date.today..Date.today + 6).to_a
  end

  def reservation
    unless params[:schedule_id]
      redirect_to movie_path(params[:movie_id]), alert: 'スケジュールを選択してください'
      return
    end
    unless params[:date]
      redirect_to movie_path(params[:movie_id]), alert: '日付を選択してください'
      return
    end
    @sheets = Sheet.left_outer_joins(:reservations).select('sheets.*, reservations.id AS reservation_id')
    @sheets_group = @sheets.group_by { |sheet| sheet[:row] }
  end

  private

  def movie_search_params
    params.permit(:keyword, :is_showing)
  end
end
