class CreateTourCategoriesTours < ActiveRecord::Migration
  def change
    create_table :tour_categories_tours do |t|
      t.belongs_to :tour, index: true
      t.belongs_to :tour_category, index: true
    end
  end
end
