class AddLinkableIdToLinks < ActiveRecord::Migration
  def change
    add_column :links, :linkable_id, :integer
  end
end
