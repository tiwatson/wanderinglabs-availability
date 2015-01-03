class ArFound < ActiveRecord::Migration
  def change
    add_column :availability_requests, :found_site, :boolean, default: false
  end
end
