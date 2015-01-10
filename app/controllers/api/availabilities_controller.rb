class Api::AvailabilitiesController < ApplicationController

  def index
    a = Availability.where(available: true).order(:id).all
    render status: 200, json: a, root: false
  end

end
