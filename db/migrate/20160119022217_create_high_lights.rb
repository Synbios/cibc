class CreateHighLights < ActiveRecord::Migration
  def change
    create_table :high_lights do |t|
      t.string :name
      t.integer :tour_id

      t.timestamps null: false
    end
  end
end
