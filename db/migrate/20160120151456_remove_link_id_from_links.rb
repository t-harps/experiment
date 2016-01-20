class RemoveLinkIdFromLinks < ActiveRecord::Migration
  def change
    remove_column :links, :link_id, :integer
  end
end
