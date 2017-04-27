class LoadShapeFile < BaseService
  def initialize(path)
    self.path = path
  end

  def call
    poland_proj4 = '+proj=tmerc +lat_0=0 +lon_0=19 +k=0.9993 +x_0=500000 +y_0=-5300000 +ellps=GRS80 +units=m +no_defs'
    poland_wkt = <<WKT
      PROJCS["ETRS89 / Poland CS92",
        GEOGCS["ETRS89",
            DATUM["European_Terrestrial_Reference_System_1989",
                SPHEROID["GRS 1980",6378137,298.257222101,
                    AUTHORITY["EPSG","7019"]],
                AUTHORITY["EPSG","6258"]],
            PRIMEM["Greenwich",0,
                AUTHORITY["EPSG","8901"]],
            UNIT["degree",0.01745329251994328,
                AUTHORITY["EPSG","9122"]],
            AUTHORITY["EPSG","4258"]],
        UNIT["metre",1,
            AUTHORITY["EPSG","9001"]],
        PROJECTION["Transverse_Mercator"],
        PARAMETER["latitude_of_origin",0],
        PARAMETER["central_meridian",19],
        PARAMETER["scale_factor",0.9993],
        PARAMETER["false_easting",500000],
        PARAMETER["false_northing",-5300000],
        AUTHORITY["EPSG","2180"],
        AXIS["y",EAST],
        AXIS["x",NORTH]]
WKT
    poland_cartesian_factory = RGeo::Cartesian.factory(:srid => 2285,
  :proj4 => poland_proj4, :coord_sys => poland_wkt)
    proj4 = "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs"
    factory = RGeo::Geographic.projected_factory(:projection_proj4 => proj4, :projection_srid => 4326)
    RGeo::Shapefile::Reader.open(path, factory: poland_cartesian_factory) do |file|
      puts "File contains #{file.num_records} records."
      file.each do |record|
        puts record.geometry
        
        Place.create!(coordinates: RGeo::Feature.cast(record.geometry, :factory => factory, :project => true), name: record.attributes['naz_glowna'],
          object_type: record.attributes['rodzaj_obi'],  object_class: record.attributes['klasa_obi'],
          voivodeship: record.attributes['woj'], county:  record.attributes['powiat'],
          commune: record.attributes['gmina'], terc: record.attributes['id_jed_p_t'])
        
      end
    end
  end

  private

  attr_accessor :path

end