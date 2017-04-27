class MapsController < ApplicationController
  def index
    @places = Place.limit(1000)
    @current = Place.find_by(id: params[:id]) || @places.first
    @voivodeships = Voivodeship.select(:name)
  end
end