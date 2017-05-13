class AllPolygon < ApplicationRecord
  UNIT_TYPES = ["Voivodeship", "County", "Commune", "RegistrationArea",
    "RegistrationUnit"]

  enum unit_type: UNIT_TYPES
end
