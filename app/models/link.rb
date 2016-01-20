class Link < ActiveRecord::Base
  belongs_to :user
  belongs_to :linkable, :polymorphic => true
  belongs_to :friend, :class_name => "User"
  belongs_to :developer, :class_name => "Developer"

  def self.link(user_id, linkable_id, linkable_type)
    Link.create(:user_id => user_id, :linkable_id => linkable_id, :linkable_type => linkable_type )
    Link.create(:user_id => linkable_id, :linkable_id => user_id, :linkable_type => linkable_type ) unless linkable_type == 'Developer'
  end
end
