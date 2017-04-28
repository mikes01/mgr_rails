class LoadRegistrationUnits < BaseService
  def initialize(path, model_class)
    self.path = path
    self.model_class = model_class
  end

  attr_accessor :path, :model_class

  def call
    file = LoadShapeFile.call(path)
    factory = RgeoFactoryBuilder.geography_factory
    file.each do |record|
      coordinates = RGeo::Feature.cast(record.geometry, factory: factory, project: true)
      model_class.create!(
        coordinates: coordinates,
        name: record.attributes['jpt_nazwa_'].force_encoding('windows-1250').encode('UTF-8'),
        terc: record.attributes['jpt_kod_je']
      )
    end
  end
end