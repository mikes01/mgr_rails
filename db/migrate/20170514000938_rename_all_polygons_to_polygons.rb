class RenameAllPolygonsToPolygons < ActiveRecord::Migration[5.0]
  def change
     rename_table :all_polygons, :polygons
  end
end
