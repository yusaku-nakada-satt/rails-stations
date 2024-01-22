namespace :reservation_remind do
  desc '予約済みのお客様にメールを送信する'
  task email_remind: :environment do
    reservations = Reservation.where('DATE(date) = ?', Time.zone.today + 1.day)

    if reservations.empty?
      Rails.logger.info "#{Time.zone.today + 1.day}の予約はありません。"
    else
      Rails.logger.info "#{Time.zone.today + 1.day}の予約は#{reservations.count}件です。"
      reservations.each do |reservation|
        ReservationMailer.with(reservation: reservation).reservation_remind_email.deliver_now
      end
    end
  end
end
