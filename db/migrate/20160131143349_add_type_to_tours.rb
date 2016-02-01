class AddTypeToTours < ActiveRecord::Migration
  def change
    add_column :tours, :type, :string
  end
end
