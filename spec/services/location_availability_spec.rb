require 'rails_helper'

RSpec.describe LocationAvailability, :type => :model do

  before() do

    AvailabilityRequest.any_instance.stub(:days_length).and_return(5)
    AvailabilityRequest.any_instance.stub(:date_start).and_return(Time.new(2015, 01, 01).to_date)
    AvailabilityRequest.any_instance.stub(:date_end).and_return(Time.new(2015, 02, 10).to_date)
  end

  let(:location_availability) { LocationAvailability.new( AvailabilityRequest.new, [true, 5], [18, ['01/02/2015']]) }

  describe '#is_available?' do

    it 'is available' do
      expect( location_availability.is_available? ).to be true
    end

    it 'sequence of booked days to return false' do
      location_availability.available = false
      expect( location_availability.is_available? ).to be false
    end

    it 'is not available if number of days is less than requested length' do
      location_availability.days_length = 4
      expect( location_availability.is_available? ).to be false
    end

    it 'not available if last day is past requested end date' do
      location_availability.date_start = Time.new(2015, 02, 7).to_date
      expect( location_availability.is_available? ).to be false
    end

    it 'not available if first available is after end date' do
      location_availability.date_start = Time.new(2015, 03, 7).to_date
      expect( location_availability.is_available? ).to be false
    end

  end


end
