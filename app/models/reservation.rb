class Reservation < ApplicationRecord
  belongs_to :sheet
  belongs_to :schedule
  has_many :screens
  has_many  :theaters

  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, presence: true
  validates :date, :sheet_id, :schedule_id, :name, presence: true
  validates :date, uniqueness: { scope: %i[schedule_id sheet_id date] }
end
