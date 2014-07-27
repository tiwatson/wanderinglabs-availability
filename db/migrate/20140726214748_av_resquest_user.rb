class AvResquestUser < ActiveRecord::Migration
  def change
    remove_column :availability_requests, :email, :string
    add_column :availability_requests, :user_id, :integer
  end
end
