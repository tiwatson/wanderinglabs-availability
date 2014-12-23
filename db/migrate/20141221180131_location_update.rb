class LocationUpdate < ActiveRecord::Migration
  def change
    add_column :locations, :contract_code, :string
    add_column :locations, :agency, :string
  end
end
