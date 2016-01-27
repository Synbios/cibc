class CreateMainSlides < ActiveRecord::Migration
  def change
    create_table :main_slides do |t|
      t.string :name
      t.integer :order
      t.boolean :active

      t.timestamps null: false
    end
  end
end
