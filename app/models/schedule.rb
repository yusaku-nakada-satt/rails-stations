class Schedule < ApplicationRecord
  belongs_to :movie
  belongs_to :theater
  has_many :reservations, dependent: nil
  has_many :sheets, dependent: nil
end
