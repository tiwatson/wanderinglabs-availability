module Locations
  class Scraper

    USER_AGENT = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/35.0.1916.153 Safari/537.36'
    attr_accessor :url

    def initialize(url)
      @url = "http://www.reserveamerica.com" + url
      require 'mechanize'
    end

    def doc
      @_doc ||= self.get.page.parser
    end

    def get
      request = Mechanize.new
      puts "Get #{url}"
      request.get(url)
      request
    end

    def get_listings
      doc.css('tr.br')
    end

    def locations
      return get_listings.map { |listing| Locations::ParseListing.new(listing).details }
    end

  end
end
