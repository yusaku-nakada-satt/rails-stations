namespace :movie_ranking do
  desc 'トップページのランキングを更新する'
  task update_ranking: :environment do
    Rails.logger.info 'トップページのランキングを更新します'
    rankings = Reservation.joins(schedule: :movie)
                              .where('DATE(reservations.date) >= ?', Time.zone.today - 30.days)
                              .group('movies.id')
                              .count
    Rails.logger.info "#{rankings.inspect}"
    Movie.where('is_showing = 1').each do |movie|
      reservations_count = rankings[movie.id] || 0
      ranking = Ranking.new(movie_id: movie.id, reserved_count: reservations_count)
      ranking.save
    end
    Rails.logger.info 'トップページのランキングを更新しました'
  end
end
