class AddStatusToLinks < ActiveRecord::Migration
  def change
    add_column :links, :status, :string
  end
end
