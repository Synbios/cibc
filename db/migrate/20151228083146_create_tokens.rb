class CreateTokens < ActiveRecord::Migration
  def change
    create_table :tokens do |t|
      t.string :type
      t.string :key
      t.datetime :expires_at

      t.timestamps null: false
    end
  end
end
