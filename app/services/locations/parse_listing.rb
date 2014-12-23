module Locations
  class ParseListing

    attr_accessor :tr

    def initialize(tr)
      @tr = tr
    end

    def details
      {
        name: name,
        slug: slug,
        state: state,
        contract_code: contract_code,
        park_id: park_id,
        agency: agency
      }
    end

    def name
      tr.css('td:nth-of-type(2)').text.downcase.titleize.strip
    end

    def slug
      href.split('/')[2]
    end

    def contract_code
      href.match(/contractCode=([A-Z]+)/,1)[1]
    end

    def park_id
      href.match(/parkId=([0-9]+)/,1)[1]
    end

    def state
      tr.css('td:nth-of-type(3)').text.gsub('Map', '')
    end

    def agency
      if tr.css('td:nth-of-type(4)').css('img')[0].present?
        tr.css('td:nth-of-type(4)').css('img')[0]['title']
      else
        tr.css('td:nth-of-type(4)').text
      end
    end

    def href
      @_href ||= tr.css('td:nth-of-type(2)').css('a')[0]['href']
    end

  end
end
