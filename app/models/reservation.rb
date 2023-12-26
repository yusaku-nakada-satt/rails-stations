class Reservation < ApplicationRecord

    attr_accessor :movie_id, :movie_name
    belongs_to :sheet
    belongs_to :schedule

    validates :email, format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i}, presence: true
    validates :movie_id, :date, :sheet_id, :schedule_id, :name, presence: true
end
