class LocationConnection

  attr_accessor :location, :request

  def initialize(location)
    @location = location

    require 'mechanize'
    @request = Mechanize.new
    @request.user_agent_alias = 'Windows Chrome'
    puts "First get #{location.url}"
    @request.get(location.url)
  end


end
