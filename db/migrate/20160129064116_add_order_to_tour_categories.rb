class AddOrderToTourCategories < ActiveRecord::Migration
  def change
    add_column :tour_categories, :order, :integer
  end
end
