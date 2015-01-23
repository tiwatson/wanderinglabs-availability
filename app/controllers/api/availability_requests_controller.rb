class Api::AvailabilityRequestsController < ApplicationController

  def index
    ar = AvailabilityRequest.where(active: true).all
    render status: 200, json: ar, root: false

  end

  def create
    user = params[:email].present? ? User.find_or_create_by(email: params[:email]) : nil
    if params[:phone].present?
      user.update_attribute(:phone, params[:phone])
    end
    
    ar = AvailabilityRequest.new(ar_params)
    ar.user = user
    if ar.save
      render status: 200, json: ar
    else
      render status: 401, json: {error: ar.errors.full_messages.join(", ") }
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
      params.require(:availability_request).permit(:location_id, :date_start, :date_end, :days_length, :active, :site_type, :email, :electric, :water, :sewer, :eq_len, :pullthru, :waterfront)
    end


end
