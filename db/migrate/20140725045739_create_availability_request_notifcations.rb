class CreateAvailabilityRequestNotifcations < ActiveRecord::Migration
  def change
    create_table :availability_request_notifcations do |t|
      t.integer :availability_request_id
      t.string :site
      t.date :date_start
      t.date :date_end
      t.integer :days_length
      t.datetime :notified_at
      t.boolean :available, default: false, null: false

      t.timestamps
    end
  end
end
