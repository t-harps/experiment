class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.integer :user_id
      t.integer :link_id

      t.timestamps null: false
    end
  end
end
