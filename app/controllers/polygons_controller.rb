class PolygonsController < ApplicationController
  def index
    factory = RGeo::Geographic.spherical_factory srid: 4326
    sw = factory.point(params[:data][:south_west_lng], params[:data][:south_west_lat])
    ne = factory.point(params[:data][:north_east_lng], params[:data][:north_east_lat])
    window = RGeo::Cartesian::BoundingBox.create_from_points(sw, ne).to_geometry
    render json: Polygon.where(unit_type: params[:data][:unit_types])
      .where("coordinates && ?", window)
  end

   def create
    @polygon = Polygon.new(polygon_params)
    if @polygon.save
      render json: @polygon, status: :created
    else
      render json: {
        html: render_to_string(partial: 'shared/polygon_form',
          locals: { polygon: @polygon }, formats: [:html]) }.to_json, status: :unprocessable_entity
    end
  end

  def update
    
  end

  def destroy
    
  end

  def render_form
    @polygon = Polygon.find_by(id: params[:id]) || Polygon.new
    respond_to do |format|
      format.json { render json: {
        html: render_to_string(partial: 'shared/polygon_form',
          locals: { polygon: @polygon }, formats: [:html]) }.to_json }
    end
  end

  private

  def polygon_params
    params.require(:polygon).permit(:name, :coordinates, :unit_type, :terc)
  end
end