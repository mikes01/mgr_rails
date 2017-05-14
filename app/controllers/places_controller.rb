class PlacesController < ApplicationController
  def index
    factory = RGeo::Geographic.spherical_factory srid: 4326
    sw = factory.point(params[:data][:south_west_lng], params[:data][:south_west_lat])
    ne = factory.point(params[:data][:north_east_lng], params[:data][:north_east_lat])
    window = RGeo::Cartesian::BoundingBox.create_from_points(sw, ne).to_geometry
    render json: Place.where(object_type: params[:data][:object_types]).where("coordinates && ?", window)
  end

  def create
    @place = Place.new(place_params)
    if @place.save
      render json: @place, status: :created
    else
      render json: {
        html: render_to_string(partial: 'shared/place_form',
          locals: { place: @place }, formats: [:html]) }.to_json, status: :unprocessable_entity
    end
  end

  def update
    @place = Place.find(params[:id])
    if @place.update(place_params)
      render json: @place, status: :ok
    else
      render json: {
        html: render_to_string(partial: 'shared/place_form',
          locals: { place: @place }, formats: [:html]) }.to_json, status: :unprocessable_entity
    end
  end

  def destroy
    @place = Place.find(params[:id])
    if @place.destroy
      render json: {}, status: :ok
    else
      render json: @place, status: :unprocessable_entity
    end
  end

  def search
    @q = Place.search(name_cont: params[:query])
    @places = @q.result(distinct: true).order(:name).limit(10)
    render json: @places
  end

  def render_form
    @place = Place.find_by(id: params[:id]) || Place.new
    respond_to do |format|
      format.json { render json: {
        html: render_to_string(partial: 'shared/place_form',
          locals: { place: @place }, formats: [:html]) }.to_json }
    end
  end

  private

  def place_params
    params.require(:place).permit(:name, :coordinates, :object_type, :object_class,
      :voivodeship, :county, :commune, :terc)
  end
end