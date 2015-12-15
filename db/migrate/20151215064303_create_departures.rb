class CreateDepartures < ActiveRecord::Migration
  def change
    create_table :departures do |t|
      t.integer :tour_id
      t.datetime :start_time
      t.integer :seats
      t.integer :price

      t.timestamps null: false
    end
  end
end
