module Locations
  class GetLocations
    def initialize

    end

    def work

      listing_urls = Locations::ListingsUrls.directory
      listing_urls += Locations::ListingsUrls.directory_federal

      puts "Urls: #{listing_urls.size}"

      listing_urls.each do |url|
        agency_name = url.split('/')[2].gsub('_', ' ')
        agency = LocationAgency.find_or_create_by(name: agency_name)

        start = 0
        first_listing = nil

        while(1) do
          puts "#{url}&startIdx=#{start}"

          locations = Locations::Scraper.new("#{url}&startIdx=#{start}").locations
          puts "locations: #{locations.size}"

          if locations.size == 0
            puts "No listings"
            break
          end

          if first_listing.nil?
            puts "setting first listing to #{locations[0][:park_id]}"
            first_listing = locations[0][:park_id]
          elsif locations.collect{ |l| l[:park_id] }.include?(first_listing)
            puts "End of listings #{start}"
            break
          end

          locations.each do |location_hash|
            next if location_invalid?(location_hash[:name])

            location = Location.find_or_initialize_by(park_id: location_hash[:park_id])

            if location_hash[:agency] == 'State'
              location.location_agency = agency
            else
              location.location_agency = LocationAgency.find_or_create_by(name: location_hash[:agency])
            end
            location_hash.delete(:agency)

            location.update(location_hash)
          end

          start = start + 25
        end
      end

    end

    def location_invalid?(name)
      return true if name.include?('Day Use')
      return true if name.include?('Group Site')
      return true if name.include?('Group Campground')
      return true if name.include?('Cabin')
      return true if name.include?('Guard Station')
      return true if name.include?('Picnic Shelter')
      return true if name.include?('Group Horse Camp')
      return true if name.include?('Group Site')
      return true if name.end_with?('Shelter')
      return true if name.end_with?('Shelters')
      return true if name.end_with?('Shelter)')
      return true if name.end_with?('Shelter Area')

    end


  end
end
