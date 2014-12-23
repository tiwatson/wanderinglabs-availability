module Locations
  class ListingsUrls
    require 'mechanize'

    class << self
      def directory
        url = 'http://www.reserveamerica.com/campgroundDirectory.do'

        request = Mechanize.new
        puts "Get #{url}"
        request.get(url)
        doc = request.page.parser

        doc.css('a').select{ |a| a['href'].include?('contractCode') }.collect{ |a| a['href'] }
      end

      def directory_federal
        url = 'http://www.reserveamerica.com/camping/National_Recreation_Reservation_System/r/campgroundDirectoryMultiState.do?contractCode=NRSO'

        request = Mechanize.new
        puts "Get #{url}"
        request.get(url)
        doc = request.page.parser

        doc.css('a').select{ |a| a['href'].include?('contractCode') }.collect{ |a| a['href'] }        
      end

    end


  end
end
