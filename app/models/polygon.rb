class Polygon < ApplicationRecord
  UNIT_TYPES = ["voivodeship", "county", "commune", "registration_area",
    "registration_unit", 'custom']

  enum unit_type: UNIT_TYPES

  validates :name, presence: true
  validates :coordinates, presence: true
  validates :terc, presence: true
  validates :unit_type, presence: true, inclusion: { in: UNIT_TYPES }
end
