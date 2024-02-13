class AddIndexToMoviesName < ActiveRecord::Migration[6.1]
  def change
    remove_index :movies, :name
    add_index :movies, :name, unique: true
  end
end
