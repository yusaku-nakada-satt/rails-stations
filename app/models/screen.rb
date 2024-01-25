class Screen < ApplicationRecord
  has_many :theaters, dependent: nil
  has_many :reservations, dependent: nil
end
