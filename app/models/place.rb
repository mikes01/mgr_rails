class Place < ApplicationRecord
  OBJECT_TYPES = ["część kolonii", "część miasta", "część osady",
    "część przysiółka", "część wsi", "kolonia", "kolonia kolonii",
    "kolonia osady", "kolonia wsi", "leśniczówka", "miasto", "osada",
    "osada kolejowa", "osada kolonii", "osada leśna", "osada leśna wsi",
    "osada młyńska", "osada osady", "osada wsi", "osiedle", "osiedle wsi",
    "przysiółek", "przysiółek kolonii", "przysiółek osady", "przysiółek wsi",
    "schronisko turystyczne", "wieś"]

  OBJECT_CLASSES = ["miejscowość"]

  validates :name, presence: true
  validates :coordinates, presence: true
  validates :object_type, presence: true, inclusion: { in: OBJECT_TYPES }
  validates :object_class, presence: true, inclusion: { in: OBJECT_CLASSES }
  validates :terc, format: { with: /\b(\d{7})\b/,
                 message: "TERC needs to have 7 digits" }

  def to_s
    name
  end
end
