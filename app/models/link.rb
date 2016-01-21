class Link < ActiveRecord::Base
  belongs_to :user
  belongs_to :linkable, :polymorphic => true
  belongs_to :friend, :class_name => "User"
  belongs_to :pending_friend, :class_name => "User"
  belongs_to :friend_request, :class_name => "User"
  belongs_to :developer, :class_name => "Developer"
  belongs_to :developer_request, :class_name => "Developer"

  before_create do
    bool = true
    if linkable_type == 'User'
      bool = (user_id != linkable_id)
    end
    bool && !Link.exists?(user_id: user_id, linkable_id: linkable_id, linkable_type: linkable_type)
  end

  def self.link(user_id, linkable_id, linkable_type)
    Link.create(:user_id => user_id, :linkable_id => linkable_id, :linkable_type => linkable_type, :status => 'pending' )
    Link.create(:user_id => linkable_id, :linkable_id => user_id, :linkable_type => linkable_type, :status => 'requested' ) unless linkable_type == 'Developer'
  end

  def self.accept(user_id, linkable_id, linkable_type)
    transaction do
      accept_one_side(user_id, linkable_id)
      accept_one_side(linkable_id, user_id) unless linkable_type == 'Developer'
    end
  end

  def self.accept_one_side(user_id, linkable_id)
    request = find_by_user_id_and_linkable_id(user_id, linkable_id)
    request.status = 'accepted'
    request.save!
  end

end
