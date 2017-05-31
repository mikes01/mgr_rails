class Polygon < ApplicationRecord
  extend GisSupport

  UNIT_TYPES = { "voivodeship" => "#a62929", "county" => "#997873", "commune" => "#402910",
    "registration_area" => "#e6f23d", "registration_unit" => "#74b32d",
    'custom' => "#b6f2de" }

  enum unit_type: UNIT_TYPES.keys

  validates :name, presence: true
  validates :coordinates, presence: true
  validates :terc, presence: true
  validates :unit_type, presence: true

  def color
    UNIT_TYPES[unit_type]
  end

  def self.in_area(north_east_lat, north_east_lng, south_west_lat, south_west_lng, unit_type)
    objects_in_area(north_east_lat, north_east_lng, south_west_lat,
    south_west_lng, unit_type, :unit_type)
  end
end
