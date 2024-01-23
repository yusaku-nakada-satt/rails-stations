class Movie < ApplicationRecord
  has_many :schedules
  has_one :ranking
  validates :name, uniqueness: true
end
