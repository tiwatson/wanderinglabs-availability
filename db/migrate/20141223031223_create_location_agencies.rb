class CreateLocationAgencies < ActiveRecord::Migration
  def change
    create_table :location_agencies do |t|
      t.string :name
      t.timestamps null: false
    end
  end
end
