class CreateShards < ActiveRecord::Migration
  def change
    create_table :shards do |t|
      t.integer :order
      t.integer :tour_avator_id

      t.timestamps null: false
    end
  end
end
