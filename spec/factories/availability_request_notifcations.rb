# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :availability_request_notifcation do
    availability_request_id 1
    site "MyString"
    date_start "2014-07-24"
    date_end "2014-07-24"
    days_length 1
    notified_at "2014-07-24 22:57:39"
    available false
  end
end
