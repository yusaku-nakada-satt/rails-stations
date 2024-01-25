class Reservation < ApplicationRecord
  belongs_to :sheet
  belongs_to :schedule
  has_many :screens, dependent: nil
  has_many  :theaters, dependent: nil

  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, presence: true
  validates :date, :name, presence: true
  validates :date, uniqueness: { scope: %i[schedule_id sheet_id date] }
end
