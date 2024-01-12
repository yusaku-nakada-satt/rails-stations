class AddColumnSchedules < ActiveRecord::Migration[6.1]
  def change
    add_reference :schedules, :theater, foreign_key: true
    add_reference :schedules, :screen, foreign_key: true
  end
end
