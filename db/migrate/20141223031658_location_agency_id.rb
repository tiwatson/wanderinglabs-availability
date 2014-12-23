class LocationAgencyId < ActiveRecord::Migration
  def change
    add_column :locations, :location_agency_id, :integer
  end
end
