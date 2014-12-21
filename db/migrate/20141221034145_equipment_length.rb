class EquipmentLength < ActiveRecord::Migration
  def change
    add_column :availability_requests, :eq_len, :integer
  end
end
