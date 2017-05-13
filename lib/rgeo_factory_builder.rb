class RgeoFactoryBuilder
  POLAND_PROJ4 = '+proj=tmerc +lat_0=0 +lon_0=19 +k=0.9993 +x_0=500000 ' +
    '+y_0=-5300000 +ellps=GRS80 +units=m +no_defs'.freeze
  #POLAND_PROJ4 = '+proj=longlat +datum=WGS84 +no_defs'

  POLAND_WKT = <<WKT
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
  def self.cartesian_factory
     RGeo::Cartesian.factory(srid: 4326, proj4: POLAND_PROJ4,
      coord_sys: POLAND_WKT)
  end

  def self.geography_factory
    RGeo::Geographic.projected_factory(projection_proj4: POLAND_PROJ4,
      projection_srid: 4326)
  end
end