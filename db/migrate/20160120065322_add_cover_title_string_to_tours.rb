class AddCoverTitleStringToTours < ActiveRecord::Migration
  def change
    add_column :tours, :cover_title, :string
  end
end
