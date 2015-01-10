class AvailabilityRequestSerializer < ActiveModel::Serializer

  attributes :id, :last_checked, :date_start, :date_end, :days_length, :active, :expired, :availabilities_count, :availabilities_active_count
  has_one :location

  def availabilities_count
    object.availabilities.count
  end

  def availabilities_active_count
    object.availabilities.is_available.count
  end

end
