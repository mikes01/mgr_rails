class RenamePlacesToPoints < ActiveRecord::Migration[5.0]
  def change
    rename_table :places, :points
  end
end
