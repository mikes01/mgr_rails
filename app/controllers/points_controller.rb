class PointsController < ApplicationController
  def index
    factory = RGeo::Geographic.spherical_factory srid: 4326
    sw = factory.point(params[:data][:south_west_lng], params[:data][:south_west_lat])
    ne = factory.point(params[:data][:north_east_lng], params[:data][:north_east_lat])
    window = RGeo::Cartesian::BoundingBox.create_from_points(sw, ne).to_geometry
    render json: Point.where(object_type: params[:data][:object_types])
      .where("coordinates && ?", window).to_json(methods: [:color])
  end

  def create
    @point = Point.new(point_params)
    if @point.save
      render json: @point, status: :created
    else
      render json: {
        html: render_to_string(partial: 'shared/point_form',
          locals: { point: @point }, formats: [:html]) }.to_json, status: :unprocessable_entity
    end
  end

  def update
    @point = Point.find(params[:id])
    if @point.update(point_params)
      render json: @point, status: :ok
    else
      render json: {
        html: render_to_string(partial: 'shared/point_form',
          locals: { point: @point }, formats: [:html]) }.to_json, status: :unprocessable_entity
    end
  end

  def destroy
    @point = Point.find(params[:id])
    if @point.destroy
      render json: {}, status: :ok
    else
      render json: @point, status: :unprocessable_entity
    end
  end

  def search
    @q = Point.search(name_cont: params[:query])
    @points = @q.result(distinct: true).order(:name).limit(10)
    render json: @points
  end

  def render_form
    @point = Point.find_by(id: params[:id]) || Point.new
    respond_to do |format|
      format.json { render json: {
        html: render_to_string(partial: 'shared/point_form',
          locals: { point: @point }, formats: [:html]) }.to_json }
    end
  end

  private

  def point_params
    params.require(:point).permit(:name, :coordinates, :object_type, :object_class,
      :voivodeship, :county, :commune, :terc)
  end
end