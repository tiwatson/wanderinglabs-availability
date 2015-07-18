class AvailabilityRequest < ActiveRecord::Base

  has_many :availabilities
  belongs_to :user
  belongs_to :location

  attr_accessor :next_date

  validates_presence_of :location, :user, :date_start, :date_end, :days_length

  before_create do |object|
    object.active = true
  end

  after_save do |object|
    if object.availabilities.is_available.to_notify.count > 0
      AvailabilityNotifier.notify(object.id).deliver

      if object.user.phone.present?
        @availabilities_new = object.availabilities.is_available.to_notify.order(:date_start)
        av = @availabilities_new.first
        link = Bitly.client.shorten(av.reserve_url)

        @client = Twilio::REST::Client.new
        @client.messages.create(
          to: "+1#{object.user.phone}",
          from: "8028585556",
          body: "WanderingLabs Availability - #{av.location.name} - #{av.date_start.strftime('%b %e, %Y')} - #{av.days_length} Nights - #{link.short_url}"
        )
      end

      object.availabilities.is_available.to_notify.update_all(notified_at: Time.now)
    end
  end

  def self.find_availability
    AvailabilityRequest.where(active: true).where('date_end > ?', Time.now).find_each do |ar|
      ar.find_availability
    end
  end

  def date_start_offset
    date_start < (Time.now.to_date + 1) ? (Time.now.to_date + 1) : date_start
  end

  def expired
    self.date_end < Time.now
  end

  def find_availability
    return if self.active == false

    self.availabilities.update_all(available: false)

    location_connection = LocationConnection.new(location)

    location_filter = LocationFilter.new(location_connection, location, self)
    location_filter.post_filters

    self.next_date = self.date_start_offset
    while next_date < (date_end - days_length)
      puts "Scraping for #{next_date}"
      scrape_data(location_connection)
    end

    puts "Done scraping #{self.id}"
    self.last_checked = Time.now
    self.save
  end

  def scrape_data(location_connection)
    location_scraper = LocationScraper.new(location_connection, location, self)
    scraped_data = location_scraper.scrape
    # puts '----------------'
    # p next_date
    # p scraped_data

    if scraped_data.empty? || scraped_data[0][1][0].nil?
      puts "EMPTY - try date #{self.next_date + 1 }"
      # raise "Bad date: #{self.id}: #{next_date}"
      self.next_date =  self.next_date + 1
    else
      new_next_date( scraped_data[0][1][0] )
      parse_scraped_data( scraped_data )
    end
  end

  def new_next_date(scraper_date)
    if scraper_date.nil?
      puts "NIL SCRAPER DATE"
      return nil
    end
    scraper_date_array = scraper_date.split('/')
    scraper_date_date = Time.new(scraper_date_array[2], scraper_date_array[0], scraper_date_array[1]).to_date
    self.next_date = scraper_date_date + 15 - days_length
  end

  def parse_scraped_data(sd)
    sd.each do |site|
      chunked = site[1].chunk{|y| y.present?}.map{|y, ys| [y, ys.length]}
      chunked.each do |chunk|

        puts "SITE - #{site[0]}"
        location_availability = LocationAvailability.new(self, chunk, site)
        availability = location_availability.availability
        if availability.present?
          puts "\t Available: true"
          availability.update_attribute(:available, true)
        end

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
      "campingDate"=>date_start_offset.strftime("%a %b %d %Y"),
      "lengthOfStay"=> days_length,
      "campingDateFlex"=>"",
      "currentMaximumWindow"=>"12",
      "contractDefaultMaxWindow"=>"MS:24,LT:18,GA:24",
      "stateDefaultMaxWindow"=>"MS:24,GA:24",
      "defaultMaximumWindow"=>"12",
      "loop"=>"",
      "siteCode"=>"",
      "lookingFor"=> site_type,
    }.merge(query_site_type)
  end

  def query_site_type
    if site_type == 2001
      {
        "camping_2001_moreOptions" => true,
        "camping_2001_3013" => eq_len,
        "camping_2001_218" => electric,
        "camping_2001_3006" => water,
        "camping_2001_3007" => sewer,
        "camping_2001_3008" => pullthru,
        "camping_2001_3011" => waterfront
      }
    elsif site_type == 2002
      {
        "camping_2002_moreOptions" => true,
        "camping_2002_3013" => eq_len,
        "camping_2002_218" => electric,
        "camping_2002_3006" => water,
        "camping_2002_3007" => sewer,
        "camping_2002_3008" => pullthru,
        "camping_2002_3011" => waterfront
      }
    elsif site_type == 2003
      {
        "camping_2003_moreOptions" => true,
        "camping_2003_3011" => waterfront

      }
    elsif site_type == 10001
      {
        "camping_10001_moreOptions" => true,
        "camping_10001_3011" => waterfront
      }
    else
      {}
    end
  end

end
