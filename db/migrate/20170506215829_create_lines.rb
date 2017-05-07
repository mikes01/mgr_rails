class CreateLines < ActiveRecord::Migration[5.0]
  def change
    create_table :lines do |t|
      t.string :name, null: false
      t.multi_line_string :coordinates, null: false
      t.string :highway, default: ""
      t.string :waterway, default: ""
      t.string :aerialway, default: ""
      t.string :barrier, default: ""
      t.string :man_made, default: ""
      t.integer :z_order, null: false
      t.string :ump_type, default: ""


      t.timestamps
    end
  end
end
