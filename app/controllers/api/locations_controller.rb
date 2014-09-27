class Api::LocationsController < ApplicationController


  def index
    @locations = Location.where('name ilike ?', "%#{params[:q]}%")
    render :status => 200, :json => { results: @locations.all }
  end


end
