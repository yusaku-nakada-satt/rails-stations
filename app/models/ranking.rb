class Ranking < ApplicationRecord
  has_many :movies, dependent: :destroy
  validates :movie_id, presence: true
  validates :reserved_count, presence: true
end
