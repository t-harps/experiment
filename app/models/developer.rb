class Developer < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :links, :as => :linkable
  has_many :users, -> { where "status = 'accepted'" }, through: :links
  #has_many :pending_users, -> { where "status = 'developer-requested'" }, through: :links, source: :linkable, :source_type => "Developer"
  #has_many :user_requests, -> { where "status = 'user-requested'" }, through: :links, source: :linkable, :source_type => "User"

  def request_link_with(user)
    links << Link.create(user_id: user.id, linkable_id: self.id, linkable_type: 'Developer', status: 'developer-requested')
  end
=begin
  def approve_user(user)
    link = links.where(status: 'user-requested', user_id: user.id).first
    unless link
      return false
    end
    link.update(status: 'approved')
  end
=end
end
