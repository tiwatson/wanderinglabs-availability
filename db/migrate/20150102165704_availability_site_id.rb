class AvailabilitySiteId < ActiveRecord::Migration
  def change
    add_column :availabilities, :site_id, :integer
  end
end
