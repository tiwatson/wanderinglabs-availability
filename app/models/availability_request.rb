class AvailabilityRequest < ActiveRecord::Base

  has_many :availability_request_notifications
  belongs_to :location
end
