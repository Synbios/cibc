class CreateDays < ActiveRecord::Migration
  def change
    create_table :days do |t|
      t.integer :number
      t.string :modal_title
      t.string :modal_content
      t.integer :previous_day_id
      t.integer :next_day_id

      t.timestamps null: false
    end
  end
end
