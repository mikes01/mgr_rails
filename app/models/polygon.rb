class Polygon < ApplicationRecord
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
end
