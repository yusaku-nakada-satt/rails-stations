class CreateRankings < ActiveRecord::Migration[6.1]
  def change
    create_table :rankings do |t|
      t.references :movie, null: false, foreign_key: true
      t.integer :reserved_count, null: false, comment: '予約数'

      t.timestamps
    end
  end
end
