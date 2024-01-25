class Movie < ApplicationRecord
  has_many :schedules, dependent: :destroy
  has_many :rankings, dependent: :destroy
  validates :name, uniqueness: true
end
