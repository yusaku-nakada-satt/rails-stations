class ReservationMailer < ApplicationMailer
  def reservation_email
    @reservation = params[:reservation]
    @schedule = Schedule.find_by(id: @reservation.schedule_id)
    @theater_name = Theater.select(:name).where(id: @schedule.theater_id).first
    @movie_name = Movie.select(:name).where(id: @schedule.movie_id).first

    raise '予約情報の取得に失敗しました' unless @reservation && @schedule && @theater_name && @movie_name

    mail(to: @reservation.email, subject: I18n.t('mailers.reservation.success'))
  end

  def reservation_remind_email
    @reservation = params[:reservation]
    @schedule = Schedule.find_by(id: @reservation.schedule_id)
    @theater_name = Theater.select(:name).where(id: @schedule.theater_id).first
    @movie_name = Movie.select(:name).where(id: @schedule.movie_id).first

    raise '予約情報の取得に失敗しました' unless @reservation && @schedule && @theater_name && @movie_name

    mail(to: @reservation.email, subject: I18n.t('mailers.reservation.remind'))
  end
end
