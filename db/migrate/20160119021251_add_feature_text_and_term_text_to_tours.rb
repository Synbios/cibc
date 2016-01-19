class AddFeatureTextAndTermTextToTours < ActiveRecord::Migration
  def change
    add_column :tours, :features, :text
    add_column :tours, :terms, :text
  end
end
