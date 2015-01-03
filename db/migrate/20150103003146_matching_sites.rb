class MatchingSites < ActiveRecord::Migration
  def change
    add_column :availability_requests, :matching_sites, :text
  end
end
