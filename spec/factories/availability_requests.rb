# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :availability_request do
    location_id 1
    active false
    date_start "2014-07-24"
    date_end "2014-07-24"
    days_length 1
    site_type 1
    electric 1
    water false
    sewer false
    pullthru false
    waterfront false
    last_checked "2014-07-24 22:57:05"
  end
end
