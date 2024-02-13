class Theater < ApplicationRecord
  has_many :screens, dependent: :destroy
  belongs_to :reservation

  validates :name, presence: true
end
