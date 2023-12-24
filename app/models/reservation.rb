class Reservation < ApplicationRecord

    validates :email, format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i}, presence: true
    validates :movie_id, :date, :sheet_id, :schedule_id, :name, presence: true
    validates :schedule_id, :sheet_id, uniqueness: true
end
