class LoadPlaces < BaseService
  def initialize(path)
    self.path = path
  end

  attr_accessor :path

  def call
    file = LoadShapeFile.call(path)

    factory = RgeoFactoryBuilder.geography_factory
    file.each do |record|
      coordinates = RGeo::Feature.cast(record.geometry, factory: factory, project: true)
      Place.create!(coordinates: coordinates,
        name: record.attributes['naz_glowna'],
        object_type: record.attributes['rodzaj_obi'],
        object_class: record.attributes['klasa_obi'],
        voivodeship: record.attributes['woj'],
        county:  record.attributes['powiat'],
        commune: record.attributes['gmina'],
        terc: record.attributes['id_jed_p_t']
      )
    end
  end
end