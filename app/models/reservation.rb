class Reservation < ApplicationRecord

    validates :email, format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i}
end
