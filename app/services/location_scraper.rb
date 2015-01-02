class LocationScraper

  attr_accessor :request, :location, :availability_request

  def initialize(location_connection, location, availability_request)
    @request = location_connection.request
    @location = location
    @availability_request = availability_request
  end

  def scrape
    self.sites.map!.with_index { |s,i| [s, self.statuses[i]] }
  end

  def sites
    @_sites ||= sites_with_availability.css('td.sn > div.siteListLabel > a').map(&:text)
  end

  def statuses
    #.statuses.chunk{|y| y}.map{|y, ys| [y, ys.length]}
    @_statuses ||= sites_with_availability.css('td.status').map { |n| n.css('a').present? ? CGI::parse(n.css('a')[0]['href'])['arvdate'].first : nil }.each_slice(14).to_a
  end

  def sites_with_availability
    @_sites_with_availability ||= doc.css('tr:has(td.a)')
  end

  def doc
    @_doc ||= self.get.page.parser
    puts @_doc
    @_doc
  end

  def get
    puts "LocationScraper - #{url}"
    request.get(url)
    request
  end

  def url
    "http://www.reserveamerica.com/campsiteCalendar.do?page=calendar&contractCode=#{location.state}&parkId=#{location.park_id}&calarvdate=#{availability_request.next_date.strftime('%m/%d/%Y')}&findavail=next"
  end

end
