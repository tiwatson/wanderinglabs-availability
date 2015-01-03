class AvailabilityRequestsController < ApplicationController

  before_filter :authenticate_user_from_token!
  before_filter :lookup_availability_request, only: [:deactivate, :deactivate_found]

  def deactivate
    @availability_request.update_attribute(:active, false)
  end

  def deactivate_found
    @availability_request.update_attributes(active: false, found_site: true)
  end

  private

  def lookup_availability_request
    @availability_request = @user.availability_requests.find_by_id(params[:id])
  end

end
