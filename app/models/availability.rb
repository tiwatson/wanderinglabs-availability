class Availability < ActiveRecord::Base

  belongs_to :availability_request

  scope :to_notify, -> { where(notified_at: nil) }
  scope :is_available, -> { where(available: true) }

  def location
    self.availability_request.location
  end

  def reserve_url
    "http://www.reserveamerica.com/camping/#{location.slug}/r/campsiteDetails.do?siteId=#{self.site_id}&contractCode=#{location.contract_code}&parkId=#{location.park_id}&offset=0&arvdate=#{self.date_start.strftime('%m/%d/%Y')}"
  end

end
