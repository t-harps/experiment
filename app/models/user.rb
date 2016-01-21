class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :links
  has_many :developers, -> { where "status = 'accepted'" }, through: :links, source: :linkable, :source_type => "Developer"
  has_many :friends, -> { where "status = 'accepted'" }, through: :links, source: :linkable, :source_type => "User"
  has_many :pending_friends, -> { where "status = 'pending'" }, :through => :links, source: :linkable, :source_type => "User"
  has_many :friend_requests, -> { where "status = 'requested'" }, :through => :links, source: :linkable, :source_type => "User"
  has_many :developer_requests, -> { where "status = 'developer-requested'" }, :through => :links, source: :linkable, :source_type => "Developer"

  def request_link_with(developer)
    links << Link.create(user_id: self.id, linkable_id: developer.id, linkable_type: 'Developer', status: 'accepted')
  end

  def approve_developer(developer)
    link = links.where(status: 'developer-requested', linkable_id: developer.id).first
    unless link
      return false
    end
    link.update(status: 'accepted')
  end
end
