class CreatePlaces < ActiveRecord::Migration[5.0]
  def change
    create_table :places do |t|
      t.st_point :coordinates
      t.string :name
      t.string :object_type
      t.string :object_class
      t.string :voivodeship
      t.string :county
      t.string :commune
      t.string :terc

      t.timestamps
    end
  end
end
