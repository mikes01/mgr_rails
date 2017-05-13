class PlacesController < ApplicationController
  def index
    factory = RGeo::Geographic.spherical_factory srid: 4326
    sw = factory.point(params[:data][:south_west_lng], params[:data][:south_west_lat])
    ne = factory.point(params[:data][:north_east_lng], params[:data][:north_east_lat])
    window = RGeo::Cartesian::BoundingBox.create_from_points(sw, ne).to_geometry
    render json: Place.where(object_type: params[:data][:object_types]).where("coordinates && ?", window)
  end

  def search
    @q = Place.search(name_cont: params[:query])
    @places = @q.result(distinct: true).order(:name).limit(10)
    render json: @places
  end
end