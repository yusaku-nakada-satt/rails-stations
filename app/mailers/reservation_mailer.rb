class ReservationMailer < ApplicationMailer
  def reservation_email
    @reservation = params[:reservation]
    @schedule = Schedule.find_by(id: @reservation.schedule_id)
    @theater_name = Theater.select(:name).where(id: @schedule.theater_id).first
    @movie_name = Movie.select(:name).where(id: @schedule.movie_id).first
    if @reservation.nil?
      raise "メール送信に失敗しました"
    end
    mail(to: @reservation.email, subject: '予約完了のお知らせ')
  end
end
