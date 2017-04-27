class LoadVoivodeships < BaseService
  def initialize(path)
    self.path = path
  end

  attr_accessor :path

  def call
    file = LoadShapeFile.call(path)
    factory = RgeoFactoryBuilder.geography_factory
    file.each do |record|
      coordinates = RGeo::Feature.cast(record.geometry, factory: factory, project: true)
      Voivodeship.create!(
        coordinates: coordinates,
        name: record.attributes['jpt_nazwa_'].force_encoding('windows-1250').encode('UTF-8'),
        area: record.attributes['jpt_powier'],
        terc: record.attributes['jpt_kod_je']
      )
    end
  end
end