class Screen < ApplicationRecord
  has_many :theaters
  has_many :reservations
end
