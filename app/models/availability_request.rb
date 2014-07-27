class AvailabilityRequest < ActiveRecord::Base

  has_many :availabilities
  belongs_to :user
  belongs_to :location

  attr_accessor :next_date

  def find_availability

    location_connection = LocationConnection.new(location)

    location_filter = LocationFilter.new(location_connection, location, self)
    location_filter.post_filters

    self.next_date = date_start
    while next_date < (date_end - days_length)
      #puts "Scraping for #{next_date}"
      scrape_data(location_connection)
    end

  end

  def scrape_data(location_connection)
    location_scraper = LocationScraper.new(location_connection, location, self)
    scraped_data = location_scraper.scrape
    # puts '----------------'
    # p next_date
    # p scraped_data

    if scraped_data.empty?
      puts "EMPTY"
    else
      new_next_date( scraped_data[0][1][0] )
      parse_scraped_data( scraped_data )
    end
  end

  def new_next_date(scraper_date)
    scraper_date_array = scraper_date.split('/')
    scraper_date_date = Time.new(scraper_date_array[2], scraper_date_array[0], scraper_date_array[1]).to_date
    self.next_date = scraper_date_date + 15 - days_length
  end

  def parse_scraped_data(sd)
    sd.each do |site|
      chunked = site[1].chunk{|y| y.present?}.map{|y, ys| [y, ys.length]}
      chunked.each do |chunk|
        location_availability = LocationAvailability.new(self, chunk, site)
        availability = location_availability.availability

        site[1].shift(chunk[1])
      end
    end
  end



  def query
    {
        "contractCode"=> location.state,
       "parkId"=> location.park_id,
       "siteTypeFilter"=>"ALL",
       "availStatus"=>"",
       "submitSiteForm"=>"true",
       "search"=>"site",
       "campingDate"=>date_start.strftime("%a %b %d %Y"),
       "lengthOfStay"=> days_length,
       "campingDateFlex"=>"",
       "currentMaximumWindow"=>"12",
       "contractDefaultMaxWindow"=>"MS:24,LT:18,GA:24",
       "stateDefaultMaxWindow"=>"MS:24,GA:24",
       "defaultMaximumWindow"=>"12",
       "loop"=>"",
       "siteCode"=>"",
       "lookingFor"=>"2001"
    }
  end


  #
  # def all_in_one
  #   require 'mechanize'
  #   request = Mechanize.new
  #   puts "First get #{location.url}"
  #   request.get(location.url)
  #   puts "POST_FILTER - #{location.url} - #{query}"
  #   request.post(location.url, query)
  #   self.next_date = date_start
  #   url = "http://www.reserveamerica.com/campsiteCalendar.do?page=calendar&contractCode=#{location.state}&parkId=#{location.park_id}&calarvdate=#{next_date.strftime('%m/%d/%Y')}&findavail=next"
  #   puts "LocationScraper - #{url}"
  #   request.get(url)
  #   puts "Request - #{request.page.links}"
  #   puts request.page.parser.css('tr:has(td.a)').css('td.status').map { |n| n.css('a').present? ? CGI::parse(n.css('a')[0]['href'])['arvdate'].first : nil }.each_slice(14).to_a
  # end


end
