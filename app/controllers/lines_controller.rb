class LinesController < ApplicationController
  def index
    factory = RGeo::Geographic.spherical_factory srid: 4326
    sw = factory.point(params[:data][:south_west_lng], params[:data][:south_west_lat])
    ne = factory.point(params[:data][:north_east_lng], params[:data][:north_east_lat])
    window = RGeo::Cartesian::BoundingBox.create_from_points(sw, ne).to_geometry
    render json: Line.where(road_type: params[:data][:road_types])
      .where("coordinates && ?", window)
  end

  def create
    @line = Line.new(line_params)
    if @line.save
      render json: @line, status: :created
    else
      render json: {
        html: render_to_string(partial: 'shared/line_form',
          locals: { line: @line }, formats: [:html]) }.to_json, status: :unprocessable_entity
    end
  end

  def update
    @line = Line.find(params[:id])
    if @line.update(line_params)
      render json: @line, status: :ok
    else
      render json: {
        html: render_to_string(partial: 'shared/line_form',
          locals: { line: @line }, formats: [:html]) }.to_json, status: :unprocessable_entity
    end
  end

  def destroy
    @line = Line.find(params[:id])
    if @line.destroy
      render json: {}, status: :ok
    else
      render json: @line, status: :unprocessable_entity
    end
  end

  def render_form
    @line = Line.find_by(id: params[:id]) || Line.new
    respond_to do |format|
      format.json { render json: {
        html: render_to_string(partial: 'shared/line_form',
          locals: { line: @line }, formats: [:html]) }.to_json }
    end
  end

  private

  def line_params
    params.require(:line).permit(:name, :coordinates, :road_type)
  end
end