class LoadShapeFile < BaseService
  def initialize(path)
    self.path = path
  end

  def call
    RGeo::Shapefile::Reader.open(path) do |file|
      puts "File contains #{file.num_records} records."
      file.each do |record|
        Place.create!(coordinates: record.geometry, name: record.attributes['naz_glowna'],
          object_type: record.attributes['rodzaj_obi'],  object_class: record.attributes['klasa_obi'],
          voivodeship: record.attributes['woj'], county:  record.attributes['powiat'],
          commune: record.attributes['gmina'], terc: record.attributes['id_jed_p_t'])
      end
    end
  end

  private

  attr_accessor :path

end