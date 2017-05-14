class Line < ApplicationRecord
  ROAD_TYPES = ["bridleway", "cycleway", "footway", "living_street", "motorway",
    "motorway_link", "path", "pedestrian", "primary", "primary_link", "residential",
    "secondary", "secondary_link", "service", "steps", "tertiary", "tertiary_link",
    "track", "track_grade1", "track_grade2", "track_grade3", "track_grade4",
    "track_grade5", "trunk", "trunk_link", "unclassified", "unknown"]

  validates :name, presence: true
  validates :coordinates, presence: true
  validates :road_type, presence: true, inclusion: { in: ROAD_TYPES }
end
