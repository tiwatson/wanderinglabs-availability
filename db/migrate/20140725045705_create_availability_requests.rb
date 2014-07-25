class CreateAvailabilityRequests < ActiveRecord::Migration
  def change
    create_table :availability_requests do |t|
      t.integer :location_id
      t.string :email
      t.boolean :active, default: false, null: false
      t.date :date_start
      t.date :date_end
      t.integer :days_length
      t.integer :site_type
      t.integer :electric
      t.boolean :water, default: false, null: false
      t.boolean :sewer, default: false, null: false
      t.boolean :pullthru, default: false, null: false
      t.boolean :waterfront, default: false, null: false
      t.datetime :last_checked

      t.timestamps
    end
  end
end
