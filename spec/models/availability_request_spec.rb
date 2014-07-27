require 'rails_helper'

RSpec.describe AvailabilityRequest, :type => :model do

  describe '#new_next_date' do

    let(:availability_request) { FactoryGirl.create(:availability_request, { days_length: 10 }) }

    it 'sets next date to search into the near future' do
      availability_request.new_next_date('01/01/2015')
      expect( availability_request.next_date ).to be Time.new(2015,01,06).to_date
    end


  end

end
