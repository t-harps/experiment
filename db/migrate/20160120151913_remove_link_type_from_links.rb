class RemoveLinkTypeFromLinks < ActiveRecord::Migration
  def change
    remove_column :links, :link_type, :string
  end
end
