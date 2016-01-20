class AddLinkableTypeToLinks < ActiveRecord::Migration
  def change
    add_column :links, :linkable_type, :string
  end
end
