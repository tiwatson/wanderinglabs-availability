class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name
      t.string :slug
      t.string :park_id
      t.string :state
    end
  end
end
