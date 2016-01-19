class AddRouteIdIntegerToDays < ActiveRecord::Migration
  def change
    add_column :days, :route_id, :integer
  end
end
