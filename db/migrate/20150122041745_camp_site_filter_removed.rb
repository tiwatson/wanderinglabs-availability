class CampSiteFilterRemoved < ActiveRecord::Migration
  def change
    remove_column :availability_requests, :matching_sites, :text
  end
end
