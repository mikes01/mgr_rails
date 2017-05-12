class CreateLines < ActiveRecord::Migration[5.0]
  def change
    create_table :lines do |t|
      t.string :name, null: false
      t.multi_line_string :coordinates, null: false, srid: 4326
      t.string :road_type, default: ""

      t.timestamps
    end
  end
end
