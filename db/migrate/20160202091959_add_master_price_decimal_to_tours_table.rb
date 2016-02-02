class AddMasterPriceDecimalToToursTable < ActiveRecord::Migration
  def change
    add_column :tours, :master_price, :decimal
  end
end
