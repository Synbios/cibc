class AddActiveBoleanToTours < ActiveRecord::Migration
  def change
    add_column :tours, :active, :boolean
  end
end
