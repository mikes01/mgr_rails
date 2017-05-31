class AddIndexes < ActiveRecord::Migration[5.0]
  def change
    add_index :points, :coordinates, using: :gist
    add_index :points, :object_type
    add_index :lines, :coordinates, using: :gist
    add_index :lines, :road_type
    add_index :polygons, :coordinates, using: :gist
    add_index :polygons, :unit_type
  end
end
