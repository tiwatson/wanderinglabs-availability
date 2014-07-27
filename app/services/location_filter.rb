class LocationFilter

  attr_accessor :request, :location, :availability_request

  def initialize(location_connection, location, availability_request)
    @request = location_connection.request
    @location = location
    @availability_request = availability_request
  end

  def post_filters
    puts "POST_FILTER - #{location.url} - #{availability_request.query}"
    request.post(location.url, availability_request.query)
  end

end
