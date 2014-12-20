class CampsiteFilter

  API_URL = 'http://api.amp.active.com/camping/campsites'
  API_KEY = 'p5uucxuptj7n5rwxyfth3vvk'

  attr_accessor :location, :availability_request

  def initialize(location, availability_request)
    @location = location
    @availability_request = availability_request
  end

  def matching_sites
    api_request['resultset']['result'].collect { |s| s['Site'] }
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
      'siteType' => availability_request.site_type,
      'eqplen' => 50, #availability_request.eq_len,
      'hookup' => availability_request.electric,
      'water' => availability_request.water? ? '3007' : nil,
      'sewer' => availability_request.sewer? ? '3007' : nil,
      'pull' => availability_request.pullthru? ? '3008' : nil
    }
  end

end
