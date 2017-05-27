class MapsController < ApplicationController

  def index
    @points = Point.limit(1000)
    @current = Point.find_by(id: params[:id]) || @points.first
    @voivodeships = Voivodeship.select(:name)
  end
end