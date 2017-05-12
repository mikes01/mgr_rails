class LinesController < ApplicationController
  def index
    factory = RGeo::Geographic.spherical_factory srid: 4326
    sw = factory.point(params[:data][:south_west_lng], params[:data][:south_west_lat])
    ne = factory.point(params[:data][:north_east_lng], params[:data][:north_east_lat])
    window = RGeo::Cartesian::BoundingBox.create_from_points(sw, ne).to_geometry
    render json: Line.where(road_type:
      ["residential", "secondary", "secondary_link", "primary", "primary_link",
        "tertiary", "tertiary_link", "living_street", "service"]
    ).where("coordinates && ?", window)
  end
end