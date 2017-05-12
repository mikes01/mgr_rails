class PlaceSerializer < ActiveModel::Serializer
  attributes :id, :name, :lat, :lng, :commune, :county, :voivodeship

  def lat
    object.coordinates.y
  end

  def lng
    object.coordinates.x
  end
end
