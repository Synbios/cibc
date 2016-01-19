class ChangeDayModalContentToText < ActiveRecord::Migration
  def change
    remove_column :days, :modal_content
    add_column :days, :modal_content, :text
  end
end
