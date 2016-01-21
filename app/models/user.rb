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
  has_many :pending_developers, -> { where "status = 'pending'" }, :through => :links, source: :linkable, :source_type => "Developer"
  has_many :developer_requests, -> { where "status = 'requested'" }, :through => :links, source: :linkable, :source_type => "Developer"
end
