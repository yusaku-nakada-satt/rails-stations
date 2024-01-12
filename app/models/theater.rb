class Theater < ApplicationRecord
  validates :name, presence: true
  has_many :screens
  belongs_to :reservation
end
