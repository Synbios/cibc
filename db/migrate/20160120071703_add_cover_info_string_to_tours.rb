class AddCoverInfoStringToTours < ActiveRecord::Migration
  def change
    add_column :tours, :cover_info, :string
  end
end
