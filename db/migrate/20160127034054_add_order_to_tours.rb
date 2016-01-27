class AddOrderToTours < ActiveRecord::Migration
  def change
    add_column :tours, :order, :integer
  end
end
