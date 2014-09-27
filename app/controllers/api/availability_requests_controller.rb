class Api::AvailabilityRequestsController < ApplicationController

  def index
    ar = AvailabilityRequest.all
    render status: 200, json: ar, root: false

  end

  def create
    ar = AvailabilityRequest.new(ar_params)
    if ar.save
      render status: 200, json: ar
    else
      render status: 401, json: ar.errors
    end
  end

  def update
    ar = AvailabilityRequest.find(params[:availability_request][:id])
    if ar.update_attributes(ar_params)
      render status: 200, json: ar
    else
      # TODO
    end
  end

  private

    def ar_params
      params.require(:availability_request).permit(:location_id, :date_start, :date_end, :days_length, :active)
    end


end
