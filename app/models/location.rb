class Location < ActiveRecord::Base

  has_many :availability_requests

  def url
    "http://www.reserveamerica.com/camping/#{slug}/r/campgroundDetails.do?contractCode=#{state}&parkId=#{park_id}"
  end


end
