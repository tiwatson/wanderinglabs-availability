class Location < ActiveRecord::Base

  has_many :availability_requests

end
