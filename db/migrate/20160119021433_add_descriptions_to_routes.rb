class AddDescriptionsToRoutes < ActiveRecord::Migration
  def change
    add_column :routes, :descriptions, :text
  end
end
