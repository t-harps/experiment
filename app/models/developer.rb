class Developer < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :links, :as => :linkable
  has_many :users, -> { where "status = 'accepted'" }, through: :links

  def request_link_with(user)
    links << Link.create(user_id: user.id, linkable_id: self.id, linkable_type: 'Developer', status: 'developer-requested')
  end

end
