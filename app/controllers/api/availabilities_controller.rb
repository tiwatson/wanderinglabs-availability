class Api::AvailabilityRequestsController < ApplicationController

  def index
    a = Availbility.where(available: true).all
    render status: 200, json: a, root: false
  end

end
