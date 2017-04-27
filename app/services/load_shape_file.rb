class LoadShapeFile < BaseService
  def initialize(path)
    self.path = path
  end

  def call
    poland_cartesian_factory = RgeoFactoryBuilder.cartesian_factory
    RGeo::Shapefile::Reader.open(path, factory: poland_cartesian_factory)
  end

  private

  attr_accessor :path

end