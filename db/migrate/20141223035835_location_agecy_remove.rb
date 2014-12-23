class LocationAgecyRemove < ActiveRecord::Migration
  def change
    remove_column :locations, :agency, :string
  end
end
