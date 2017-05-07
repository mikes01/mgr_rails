class CreatePopulations < ActiveRecord::Migration[5.0]
  def change
    create_table :populations do |t|
      t.multi_polygon :coordinates, null: false
      t.integer :total, null: false
      t.integer :total_0_14, null: false
      t.integer :total_15_64, null: false
      t.integer :total_65, null: false
      t.integer :total_male, null: false
      t.integer :total_female, null: false
      t.integer :male_0_14, null: false
      t.integer :male_15_64, null: false
      t.integer :male_65, null: false
      t.integer :female_0_14, null: false
      t.integer :female_15_64, null: false
      t.integer :female_65, null: false
      t.float :female_ratio, null: false

      t.timestamps
    end
  end
end
