class Polygon < ApplicationRecord
  UNIT_TYPES = ["Voivodeship", "County", "Commune", "RegistrationArea",
    "RegistrationUnit"]

  enum unit_type: UNIT_TYPES

  validates :name, presence: true
  validates :coordinates, presence: true
  validates :terc, presence: true
  validates :unit_type, presence: true, inclusion: { in: UNIT_TYPES }
end
