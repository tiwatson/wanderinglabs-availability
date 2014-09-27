class AvailabilityRequestSerializer < ActiveModel::Serializer

  attributes :id, :date_start, :date_end, :days_length, :active, :last_checked, :expired
  has_one :location
end
