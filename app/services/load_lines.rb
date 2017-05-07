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
      other_tags = record.attributes["other_tags"].gsub('"', "").split(',').map do |x|
        x.split('=>')
      end.reject! { |x| x.size < 2 }.to_h
      p other_tags
      Line.create!(coordinates: coordinates,
        name: record.attributes['name'],
        highway: record.attributes['highway'],
        waterway: record.attributes['waterway'],
        aerialway: record.attributes['aerialway'],
        barrier:  record.attributes['barrier'],
        man_made: record.attributes['man_made'],
        z_order: record.attributes['z_order'],
        ump_type: other_tags["ump:type"]
      )
    end
  end
end