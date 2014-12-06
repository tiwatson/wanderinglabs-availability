class Availability < ActiveRecord::Base

  belongs_to :availability_request

  scope :to_notify, -> { where(notified_at: nil) }

end
