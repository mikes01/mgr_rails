class CastPlacesCoordinatesToGeometryType < ActiveRecord::Migration[5.0]
  def change
    change_column :places, :coordinates, 'geometry(Point) USING coordinates::geometry'
  end
end
