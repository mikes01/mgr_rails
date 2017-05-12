class LoadLines < BaseService
  def initialize(path)
    self.path = path
  end

  attr_accessor :path

  def call
    file = LoadShapeFile.call(path)

    factory = RgeoFactoryBuilder.geography_factory
    file.each do |record|
      coordinates = RGeo::Feature.cast(record.geometry, factory: factory, project: true)
      Line.create!(coordinates: coordinates,
        name: record.attributes['name'],
        road_type: record.attributes['fclass']
      )
    end
  end
end