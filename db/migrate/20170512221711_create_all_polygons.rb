class CreateAllPolygons < ActiveRecord::Migration[5.0]
  def change
    create_table :all_polygons do |t|
      t.string :name, null: false
      t.multi_polygon :coordinates, null: false
      t.string :terc, null: false
      t.integer :unit_type, null: false

      t.timestamps
    end
  end
end
