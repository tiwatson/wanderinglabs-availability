class LocationConnection

  USER_AGENT = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/35.0.1916.153 Safari/537.36'
  attr_accessor :location, :request

  def initialize(location)
    @location = location

    require 'mechanize'
    @request = Mechanize.new
    puts "First get #{location.url}"
    @request.get(location.url)
  end


end
