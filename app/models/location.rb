class Location < ActiveRecord::Base

  has_many :availability_requests
  belongs_to :location_agency
  
  def url
    "http://www.reserveamerica.com/camping/#{slug}/r/campgroundDetails.do?contractCode=#{state}&parkId=#{park_id}"
  end

end
