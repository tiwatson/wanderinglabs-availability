class LocationAvailability

  attr_accessor :ar, :available, :days_length, :site_number, :date_start

  def initialize(ar, chunk, site)
    @ar = ar
    @available = chunk[0]
    @days_length = chunk[1]

    @site_number = site[0]
    if site[1][0].present?
      date_start_array = site[1][0].split('/')
      @date_start = Time.new(date_start_array[2],date_start_array[0],date_start_array[1]).to_date
    end

  end

  def is_available?
    p date_start
    p ar.date_end
    available == true &&
    days_length >= ar.days_length &&
    (date_start + ar.days_length) < ar.date_end
  end

  def availability
    return unless is_available?
    @_availability ||= Availability.find_or_create_by(availability_request_id: ar.id, site: site_number, date_start: date_start, days_length: days_length)
  end


end
