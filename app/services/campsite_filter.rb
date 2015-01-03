class CampsiteFilter

  API_URL = 'http://api.amp.active.com/camping/campsites'
  API_KEY = Rails.application.secrets.campsites_api_key

  attr_accessor :location, :availability_request

  def initialize(location, availability_request)
    @location = location
    @availability_request = availability_request
  end

  def matching_sites
    api_request['resultset']['result'].select { |s| site_type_match?(s['SiteType']) }.collect { |s| s['SiteId'] }
  end

  def api_request
    HTTParty.get("#{API_URL}?api_key=#{API_KEY}&#{query_hash.to_query}")
  end

  def query_hash
    {
      'contractCode' => location.state,
      'parkId' => location.park_id,
      'arvdate' => availability_request.date_start.strftime("%m/%d/%Y"),
      'lengthOfStay' => availability_request.days_length,
      #'siteType' => availability_request.site_type,
      'eqplen' => availability_request.eq_len,
      'hookup' => availability_request.electric,
      'water' => availability_request.water? ? '3007' : nil,
      'sewer' => availability_request.sewer? ? '3007' : nil,
      'pull' => availability_request.pullthru? ? '3008' : nil
    }
  end

  # API doesn't seems to include tent when sending 2001
  def site_type_match?(site_type)
    if availability_request.site_type == 2001
      return false if site_type == 'Tent Only'
    end
    return true
  end

end
