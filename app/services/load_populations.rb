class LoadPopulations < BaseService
  def initialize(path)
    self.path = path
  end

  attr_accessor :path

  def call
    file = LoadShapeFile.call(path)

    factory = RgeoFactoryBuilder.geography_factory
    file.each do |record|
      coordinates = RGeo::Feature.cast(record.geometry, factory: factory, project: true)
      Population.create!(coordinates: coordinates,
        total: record.attributes['TOT'],
        total_0_14: record.attributes['TOT_0_14'],
        total_15_64: record.attributes['TOT_15_64'],
        total_65: record.attributes['TOT_65__'],
        total_male:  record.attributes['TOT_MALE'],
        total_female: record.attributes['TOT_FEM'],
        male_0_14: record.attributes['MALE_0_14'],
        male_15_64: record.attributes['MALE_15_64'],
        male_65: record.attributes['MALE_65__'],
        female_0_14: record.attributes['FEM_0_14'],
        female_15_64: record.attributes['FEM_15_64'],
        female_65: record.attributes['FEM_65__'],
        female_ratio: record.attributes['FEM_RATIO']
      )
    end
  end
end