class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :links
  has_many :developers, through: :links, source: :linkable, :source_type => "Developer"
  has_many :friends, through: :links, source: :linkable, :source_type => "User"
end
