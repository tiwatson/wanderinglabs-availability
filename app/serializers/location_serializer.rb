class LocationSerializer < ActiveModel::Serializer
  attributes :id, :name, :state, :description

  def description
    "#{object.state} - #{object.location_agency.name}"
  end
end
