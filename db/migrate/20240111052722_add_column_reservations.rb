class AddColumnReservations < ActiveRecord::Migration[6.1]
  def change
    add_reference :reservations, :screen, foreign_key: true
    add_reference :reservations, :theater, foreign_key: true
  end
end
